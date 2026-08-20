#!/usr/bin/env bash
# ingest-loop.sh — run the "next ingest" pass repeatedly, one fresh Claude
# session per ingest (a new process = a clean context, same effect as /clear).
#
# When the current wave in priority-ingest.md is depleted, the script refills it
# with the next unfinished wave from _work/ingest-queue.md and keeps going, so a
# single run can drain the whole 303-source queue.
#
# Crash safety: a pass counts as done ONLY if it produced a new commit. A pass
# that dies mid-ingest (session limit, API error, network drop, Ctrl-C) has its
# partial edits rolled back, so re-running the script later always resumes from
# a clean tree. Exit 20 = out of quota, restart when it resets.
#
# Usage:
#   ./tools/ingest-loop.sh                # run until every source is ingested
#   ./tools/ingest-loop.sh -n 5           # at most 5 ingest passes
#   ./tools/ingest-loop.sh --model sonnet
#   ./tools/ingest-loop.sh --retries 3    # transient-error retries per source
#   ./tools/ingest-loop.sh --rollback-dirty  # discard a killed pass's leftovers
#   ./tools/ingest-loop.sh --dry-run      # show the command it would run
#   ./tools/ingest-loop.sh --refill-only  # just refill the wave, run nothing
#
# Stop it gracefully mid-run: touch tools/.stop-ingest   (or Ctrl-C)

set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO" || exit 1

WAVE="priority-ingest.md"          # current wave (the agent works from this)
MASTER="_work/ingest-queue.md"     # full 303-source queue, wave-ordered
MANIFEST="_work/manifest.tsv"
STOPFILE="tools/.stop-ingest"
LOGDIR="_work/ingest-logs"
STATEFILE="$LOGDIR/last-run.env"

# Paths the ingest agent is allowed to touch. Rollback and the dirty-tree
# preflight are scoped to exactly these, so CLAUDE.md, .obsidian/, .claude/ and
# un-ingested raw/ sources are never disturbed.
AGENT_PATHS=(wiki "$WAVE")

MAX=0                     # 0 = until the master queue is empty
MODEL="${INGEST_MODEL:-opus}"
PERM="${INGEST_PERMISSION_MODE:-auto}"
PROMPT="${INGEST_PROMPT:-Proceed with the next ingest in priority-ingest.md}"
SLEEP="${INGEST_SLEEP:-5}"
RETRIES="${INGEST_RETRIES:-3}"
BACKOFF="${INGEST_BACKOFF:-30}"   # first retry delay, doubled each attempt
DRY=0
REFILL_ONLY=0
ROLLBACK_DIRTY=0

EXIT_LIMIT=20             # hit the session/usage limit — resume after reset

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n|--max)           MAX="$2"; shift 2 ;;
    --model)            MODEL="$2"; shift 2 ;;
    --permission-mode)  PERM="$2"; shift 2 ;;
    --prompt)           PROMPT="$2"; shift 2 ;;
    --sleep)            SLEEP="$2"; shift 2 ;;
    --retries)          RETRIES="$2"; shift 2 ;;
    --dry-run)          DRY=1; shift ;;
    --refill-only)      REFILL_ONLY=1; shift ;;
    --rollback-dirty)   ROLLBACK_DIRTY=1; shift ;;
    -h|--help)          sed -n '2,25p' "$0"; exit 0 ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
done

command -v claude >/dev/null || { echo "claude CLI not found in PATH" >&2; exit 1; }
[[ -f "$WAVE"   ]] || { echo "$WAVE not found" >&2; exit 1; }
[[ -f "$MASTER" ]] || { echo "$MASTER not found" >&2; exit 1; }
mkdir -p "$LOGDIR"
rm -f "$STOPFILE"

# ---------------------------------------------------------------- helpers ----

open_in()  { grep -c '^[[:space:]]*-[[:space:]]\[ \][[:space:]]*`' "$1" 2>/dev/null || true; }

head_sha() { git rev-parse HEAD 2>/dev/null; }

# The filename on the first open line of the wave — i.e. what the next pass
# will ingest. Recorded so an interrupted run can say where it stopped.
next_source() {
  grep -m1 '^[[:space:]]*-[[:space:]]\[ \]' "$WAVE" 2>/dev/null \
    | sed -n 's/.*`\([^`]*\)`.*/\1/p'
}

# Uncommitted changes inside the agent's own paths, staged or not, tracked or
# not. Empty output = clean.
agent_dirty() { git status --porcelain -- "${AGENT_PATHS[@]}" 2>/dev/null; }

# Discard a partial ingest: unstage everything the agent staged (including the
# raw/ source it was about to commit), restore tracked files it edited, and
# delete new wiki pages it created. Never touches raw/ on disk.
rollback() {
  local why="${1:-partial pass}"
  [[ -n "$(agent_dirty)" ]] || return 0
  echo "[ingest-loop] rolling back $why:"
  agent_dirty | sed 's/^/    /'
  git reset -q -- wiki "$WAVE" raw 2>/dev/null
  git checkout -q -- wiki "$WAVE" 2>/dev/null
  git clean -fdq wiki 2>/dev/null
  if [[ -n "$(agent_dirty)" ]]; then
    echo "[ingest-loop] WARNING: tree still dirty after rollback — inspect by hand:" >&2
    agent_dirty | sed 's/^/    /' >&2
    return 1
  fi
  echo "[ingest-loop] rollback clean — wave and wiki are back at $(head_sha | cut -c1-7)."
  return 0
}

# Propagate every [x] in the current wave file back into the master queue,
# matched on the `filename` in backticks. Keeps the master authoritative.
sync_master() {
  local list="$LOGDIR/.done-files"
  grep '^[[:space:]]*-[[:space:]]\[[xX]\]' "$WAVE" 2>/dev/null \
    | sed -n 's/.*`\([^`]*\)`.*/\1/p' > "$list"
  [[ -s "$list" ]] || { rm -f "$list"; return 0; }
  awk '
    NR == FNR { if ($0 != "") done[$0] = 1; next }
    {
      if ($0 ~ /^[ \t]*-[ \t]*\[ \]/ && match($0, /`[^`]+`/)) {
        f = substr($0, RSTART + 1, RLENGTH - 2)
        if (f in done) sub(/\[ \]/, "[x]", $0)
      }
      print
    }' "$list" "$MASTER" > "$MASTER.tmp" && mv "$MASTER.tmp" "$MASTER"
  rm -f "$list"
}

# The master queue is tracked so its progress survives a lost working copy, but
# the ingest agent does not know about it — the loop commits its own ticks.
commit_master() {
  git ls-files --error-unmatch "$MASTER" >/dev/null 2>&1 || return 0
  git diff --quiet -- "$MASTER" "$MANIFEST" 2>/dev/null && return 0
  git add -- "$MASTER" "$MANIFEST" 2>/dev/null
  git commit -q -m "chore(queue): sync ingest-queue after ${1:-ingest}" -- "$MASTER" "$MANIFEST" 2>/dev/null \
    && echo "[ingest-loop] queue progress committed."
}

# Rewrite the wave file with the first wave in the master that still has work.
# Returns 0 if a wave was written, 1 if the master queue is fully ingested.
refill_wave() {
  awk '
    /^## / { if (section != "" && has_open) { printf "%s", section; printed = 1; exit }
             section = $0 "\n"; has_open = 0; next }
    section != "" { section = section $0 "\n"; if ($0 ~ /^[ \t]*-[ \t]*\[ \]/) has_open = 1 }
    END { if (printed) exit 0
          if (section != "" && has_open) { printf "%s", section; exit 0 }
          exit 1 }
  ' "$MASTER" > "$LOGDIR/.next-wave" || return 1
  [[ -s "$LOGDIR/.next-wave" ]] || return 1

  # keep the wave file's preamble (everything above its first "## " heading)
  awk '/^## / { exit } { print }' "$WAVE" > "$WAVE.tmp"
  cat "$LOGDIR/.next-wave" >> "$WAVE.tmp"
  mv "$WAVE.tmp" "$WAVE"
  rm -f "$LOGDIR/.next-wave"
  return 0
}

# Why did a pass end? The CLI exits 0 with subtype "success" even when it was
# cut off by the session limit, so rc is not a health signal. The final
# "result" event is: it carries is_error / api_error_status / the stop message.
# Only that event and stderr are inspected — the rest of the transcript quotes
# the paper being ingested, where a stray "503" means nothing.
# Echoes: limit | transient | error | ok
classify() {
  local raw="$1" err="$2" ev stderr_blob

  ev="$(grep '"type":"result"' "$raw" 2>/dev/null | tail -1)"
  stderr_blob="$(tail -c 4000 "$err" 2>/dev/null)"

  local net_re='overloaded|econnreset|enotfound|etimedout|socket hang up|fetch failed|network error|connection (reset|refused|closed)'

  # No result event at all => the process died before finishing (kill, crash,
  # dropped connection). Blame the network only if stderr says so.
  if [[ -z "$ev" ]]; then
    grep -qiE "$net_re" <<<"$stderr_blob" && { echo transient; return; }
    echo error; return
  fi

  local is_err http_status text
  if command -v jq >/dev/null; then
    is_err="$(jq -r '.is_error // false'        <<<"$ev" 2>/dev/null)"
    http_status="$(jq -r '.api_error_status // ""'   <<<"$ev" 2>/dev/null)"
    text="$(jq -r '(.result // "") | tostring'  <<<"$ev" 2>/dev/null)"
  else
    is_err="$(grep -qE '"is_error":[[:space:]]*true' <<<"$ev" && echo true || echo false)"
    http_status="$(sed -n 's/.*"api_error_status":[[:space:]]*\([0-9]*\).*/\1/p' <<<"$ev")"
    text="$ev"
  fi

  # Out of quota: the message names a limit, whatever the status code.
  if grep -qiE 'session limit|usage limit|hit your limit|quota (exceeded|reached)' <<<"$text"; then
    echo limit; return
  fi
  # Retryable: overload, throttling, upstream 5xx, or a dropped connection.
  # The result text is the agent's own prose (it may well quote a "503" from
  # the paper), so it only counts when framed as an API error.
  if [[ "$http_status" =~ ^(429|500|502|503|504|529)$ ]] \
     || grep -qiE "(api|http|request) error.{0,40}($net_re)" <<<"$text" \
     || grep -qiE "$net_re" <<<"$stderr_blob"; then
    echo transient; return
  fi
  [[ "$is_err" == "true" ]] && { echo error; return; }
  grep -qE '"subtype":"error_[a-z_]*"' <<<"$ev" && { echo error; return; }
  echo ok
}

# The reset time the CLI printed, if any — shown so you know when to restart.
limit_reset() {
  { grep '"type":"result"' "$1" 2>/dev/null | tail -1; tail -c 4000 "$2" 2>/dev/null; } \
    | grep -ohiE 'resets [^"\\]*' | head -1
}

save_state() {
  cat > "$STATEFILE" <<EOF
# written by tools/ingest-loop.sh — diagnostics only, safe to delete
LAST_RUN_END="$(date +%Y-%m-%dT%H:%M:%S%z)"
LAST_PASS="${1:-0}"
LAST_SOURCE="${2:-}"
LAST_OUTCOME="${3:-}"
LAST_HEAD="$(head_sha)"
OPEN_IN_WAVE="$(open_in "$WAVE")"
OPEN_IN_MASTER="$(open_in "$MASTER")"
EOF
}

# Render the stream-json event feed as readable lines, live.
render() {
  if command -v jq >/dev/null; then
    # drop any non-JSON line so one stray warning can't kill the renderer
    grep --line-buffered '^{' | jq --unbuffered -rj '
      if .type == "assistant" then
        ( .message.content[]? |
          if   .type == "text"     then .text
          elif .type == "thinking" then ""
          elif .type == "tool_use" then
            "\n  ⚙ " + .name + "(" +
            (((.input.file_path // .input.command // .input.pattern // .input.skill // "")
              | tostring)[0:100]) + ")\n"
          else "" end )
      elif .type == "result" then
        "\n\n--- " + (.subtype // "result") +
        "  turns=" + ((.num_turns // 0) | tostring) +
        "  cost=$" + ((.total_cost_usd // 0) | tostring) + " ---\n"
      else empty end' 2>/dev/null
  else
    cat
  fi
}

pass=0
current_source=""
trap 'echo; echo "[ingest-loop] interrupted"; rollback "interrupted pass"; save_state "$pass" "$current_source" interrupted; exit 130' INT TERM

# ------------------------------------------------------------------ setup ----

if (( REFILL_ONLY )); then
  sync_master
  if refill_wave; then echo "[ingest-loop] refilled $WAVE — $(open_in "$WAVE") item(s) open."
  else echo "[ingest-loop] master queue fully ingested — nothing to refill."; fi
  commit_master "refill"
  exit 0
fi

# ------------------------------------------------------------- resume gate ---

if [[ -f "$STATEFILE" ]]; then
  # shellcheck disable=SC1090
  ( . "$STATEFILE" 2>/dev/null
    case "${LAST_OUTCOME:-}" in
      limit|error|transient-exhausted|no-op|dirty|interrupted) ;;
      *) exit 0 ;;                       # done / maxed / stopfile: nothing to report
    esac
    echo "[ingest-loop] previous run ended ${LAST_RUN_END} at pass ${LAST_PASS} (${LAST_OUTCOME})"
    [[ -n "${LAST_SOURCE:-}" ]] && echo "[ingest-loop]   it was working on: ${LAST_SOURCE} — that pass was rolled back, so it starts over." )
fi

if [[ -n "$(agent_dirty)" ]]; then
  if (( ROLLBACK_DIRTY )); then
    rollback "leftovers from an earlier run" || exit 1
  else
    echo "[ingest-loop] refusing to start: uncommitted changes in wiki/ or $WAVE." >&2
    agent_dirty | sed 's/^/    /' >&2
    echo "[ingest-loop] These are most likely a killed pass's partial ingest." >&2
    echo "[ingest-loop] Discard them with:  ./tools/ingest-loop.sh --rollback-dirty" >&2
    echo "[ingest-loop] Or commit them yourself if the ingest was in fact complete." >&2
    exit 1
  fi
fi

# ------------------------------------------------------------------- loop ----

outcome=done
while :; do
  [[ -f "$STOPFILE" ]] && { echo "[ingest-loop] stop file present — stopping."; rm -f "$STOPFILE"; outcome=stopfile; break; }
  (( MAX > 0 && pass >= MAX )) && { echo "[ingest-loop] reached --max $MAX — stopping."; outcome=maxed; break; }

  left="$(open_in "$WAVE")"

  # Wave depleted → fold results into the master and pull the next wave.
  if (( left == 0 )); then
    sync_master
    if refill_wave; then
      commit_master "wave refill"
      left="$(open_in "$WAVE")"
      echo "[ingest-loop] wave complete — refilled $WAVE: $(sed -n '/^## /{p;q;}' "$WAVE") ($left open)"
      (( left == 0 )) && { echo "[ingest-loop] refilled wave has no open items — stopping."; outcome=empty-wave; break; }
    else
      echo "[ingest-loop] every source in $MASTER is ingested. Done."
      outcome=done
      break
    fi
  fi

  pass=$(( pass + 1 ))
  current_source="$(next_source)"
  attempt=0

  # Retry the SAME source on transient failures; each attempt starts from a
  # rolled-back, clean tree so nothing is ever ingested twice.
  while :; do
    attempt=$(( attempt + 1 ))
    stamp="$(date +%Y%m%d-%H%M%S)"
    log="$LOGDIR/$stamp-pass$pass.log"
    raw="$LOGDIR/$stamp-pass$pass.jsonl"
    err="$LOGDIR/$stamp-pass$pass.err"
    echo "=== [ingest-loop] pass $pass${attempt:+ (attempt $attempt)} — ${current_source:-?} — $left open in wave, $(open_in "$MASTER") open overall — log: $log ==="

    if (( DRY )); then
      echo "claude -p \"$PROMPT\" --model $MODEL --permission-mode $PERM --output-format stream-json --verbose"
      exit 0
    fi

    before_head="$(head_sha)"

    # Fresh process each pass => fresh context, no /clear needed.
    # stream-json + --verbose makes the log fill live instead of only at the end.
    claude -p "$PROMPT" \
          --model "$MODEL" \
          --permission-mode "$PERM" \
          --output-format stream-json --verbose \
          --add-dir "$REPO" \
          2>"$err" | tee "$raw" | render | tee "$log"
    rc="${PIPESTATUS[0]}"

    after_head="$(head_sha)"
    reason="$(classify "$raw" "$err")"
    (( rc != 0 )) && [[ "$reason" == ok ]] && reason=error

    # A pass is done only if it committed. Anything else is partial work.
    if [[ "$before_head" != "$after_head" ]]; then
      rollback "stray edits left after the commit"
      sync_master
      commit_master "$current_source"
      after_left="$(open_in "$WAVE")"
      echo "[ingest-loop] pass $pass done — $after_left open in wave, $(open_in "$MASTER") open overall."
      if [[ "$reason" == limit ]]; then
        echo "[ingest-loop] committed, then hit the session limit. $(limit_reset "$raw" "$err")"
        echo "[ingest-loop] Re-run this script once your quota resets; it resumes at the next open item."
        save_state "$pass" "$current_source" limit
        echo "[ingest-loop] finished after $pass pass(es). Logs in $LOGDIR/"
        exit "$EXIT_LIMIT"
      fi
      current_source=""            # nothing in flight any more
      (( SLEEP > 0 )) && sleep "$SLEEP"
      break   # next source
    fi

    # No commit → nothing of this ingest may survive.
    rollback "pass $pass ($reason)" || { save_state "$pass" "$current_source" dirty; exit 1; }

    case "$reason" in
      limit)
        echo "[ingest-loop] session limit reached mid-ingest — ${current_source:-?} was rolled back, nothing half-written. $(limit_reset "$raw" "$err")"
        echo "[ingest-loop] Re-run this script once your quota resets; it restarts this source from scratch."
        save_state "$pass" "$current_source" limit
        echo "[ingest-loop] finished after $pass pass(es). Logs in $LOGDIR/"
        exit "$EXIT_LIMIT"
        ;;
      transient)
        if (( attempt > RETRIES )); then
          echo "[ingest-loop] transient failures on ${current_source:-?} exhausted $RETRIES retries — stopping. See $raw"
          save_state "$pass" "$current_source" transient-exhausted
          outcome=transient-exhausted; break 2
        fi
        backoff=$(( BACKOFF * (1 << (attempt - 1)) ))
        echo "[ingest-loop] transient failure (rc=$rc) — retrying ${current_source:-?} in ${backoff}s (attempt $((attempt+1))/$((RETRIES+1)))."
        sleep "$backoff"
        ;;
      error)
        echo "[ingest-loop] pass $pass failed (rc=$rc) — stopping. See $raw"
        save_state "$pass" "$current_source" error
        outcome=error; break 2
        ;;
      *)
        echo "[ingest-loop] pass $pass produced no commit and no error — stopping to avoid a spin. See $raw"
        save_state "$pass" "$current_source" no-op
        outcome=no-op; break 2
        ;;
    esac
  done
done

save_state "$pass" "$current_source" "$outcome"
echo "[ingest-loop] finished after $pass pass(es). Logs in $LOGDIR/"
[[ "$outcome" == "error" || "$outcome" == "transient-exhausted" || "$outcome" == "no-op" ]] && exit 1
exit 0
