#!/usr/bin/env bash
# UserPromptSubmit hook: tells the agent how full its conversation is, once it
# gets long. The numbers come from the status line (~/.claude/ctx/<session>.json);
# without it this hook stays silent. Thresholds are initial guesses, to be
# calibrated from feedback: CTX_WARN_TOKENS, CTX_STOP_TOKENS (or 60 % / 80 %).
# Needs: jq.

input=$(cat)
sid=$(printf '%s' "$input" | jq -r '.session_id // empty' 2>/dev/null)
f=~/.claude/ctx/$sid.json
[[ -n $sid && -r $f ]] || exit 0

eval "$(jq -r '@sh "pct=\(.pct // 0)", @sh "tokens=\(.tokens // 0)"' "$f" 2>/dev/null)"
pct=${pct:-0}; tokens=${tokens:-0}
warn=${CTX_WARN_TOKENS:-300000}
stop=${CTX_STOP_TOKENS:-500000}

if (( tokens >= stop || pct >= 80 )); then
  msg="Context: ~$((tokens/1000))k tokens (${pct}%). This conversation is long enough to hurt the work. After the current step: bring the task files up to date, write the handoff, and ask the owner to continue in a new session."
elif (( tokens >= warn || pct >= 60 )); then
  msg="Context: ~$((tokens/1000))k tokens (${pct}%). Plan for a handoff at the next natural boundary (end of a chunk or phase)."
else
  exit 0
fi

jq -cn --arg m "$msg" '{hookSpecificOutput: {hookEventName: "UserPromptSubmit", additionalContext: $m}}'
