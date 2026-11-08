#!/usr/bin/env bash
# SessionStart hook (matcher "compact"): after the conversation was compacted,
# tells the agent so, instead of hoping it notices the summary. No dependencies.

cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"The earlier conversation was just compacted into a summary; details are lost. The project files are the source of truth, not the summary. Finish only the current atomic step, bring the task files up to date, write the handoff, and ask the owner to continue in a new session."}}
JSON
