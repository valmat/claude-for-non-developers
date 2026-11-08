#!/usr/bin/env bash
# Status line for Claude Code (terminal only).
# Shows the model, how full the conversation is, and the subscription limits.
# Also writes the context usage to ~/.claude/ctx/<session_id>.json, so that the
# project's hook (.claude/hooks/ctx-warn.sh) can tell the agent.
# Needs: jq.

input=$(cat)

R=$'\e[0m'; GREEN=$'\e[32m'; YELLOW=$'\e[33m'; RED=$'\e[1;31m'; CYAN=$'\e[36m'; GRAY=$'\e[90m'

eval "$(printf '%s' "$input" | jq -r '
  @sh "sid=\(.session_id // "")",
  @sh "model=\(.model.display_name // "?")",
  @sh "pct=\(.context_window.used_percentage // 0)",
  @sh "size=\(.context_window.context_window_size // 0)",
  @sh "used=\((.context_window.current_usage // {}) | ((.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0)))",
  @sh "rl5=\(.rate_limits.five_hour.used_percentage // "")",
  @sh "rl7=\(.rate_limits.seven_day.used_percentage // "")"
' 2>/dev/null)"
pct=${pct%.*}; pct=${pct:-0}; used=${used:-0}

# For the agent: last known usage of this session.
if [[ -n $sid ]]; then
  dir=~/.claude/ctx
  mkdir -p "$dir" 2>/dev/null
  printf '{"pct":%s,"tokens":%s,"size":%s,"ts":%s}\n' "$pct" "$used" "${size:-0}" "$(date +%s)" \
    > "$dir/$sid.json" 2>/dev/null
  # Old sessions: drop files older than a week (cheap, at most once a day).
  stamp="$dir/.cleaned"
  if [[ ! -e $stamp || -n $(find "$stamp" -mmin +1440 2>/dev/null) ]]; then
    find "$dir" -name '*.json' -mtime +7 -delete 2>/dev/null; : > "$stamp"
  fi
fi

# Colour by absolute size as well as by percent: with a very large window the
# percent stays low long after a conversation has become too long to work well.
if   (( pct >= 80 || used >= 500000 )); then C=$RED
elif (( pct >= 60 || used >= 300000 )); then C=$YELLOW
else C=$GREEN; fi

out="${CYAN}[${model}]${R} ${C}context: ${pct}% (~$((used/1000))k)${R}"
[[ -n $rl5 ]] && out+="${GRAY} · limits 5h: ${rl5%.*}%${R}"
[[ -n $rl7 ]] && out+="${GRAY}  7d: ${rl7%.*}%${R}"
printf '%s\n' "$out"
