# Context helpers

A conversation that grows too long works worse, burns the subscription limits faster, and at some
point is compacted into a summary that loses details. The set does not depend on seeing this: work
is resumable from files at any point. The helpers below only let the agent (and the owner) notice
it earlier. Install what works in the owner's setup; skip what does not. Never block the install.

What is known (as of this set's version) and what is not:

- The **status line** receives the context usage (`context_window` in its input). It exists only
  in the terminal CLI, not in the desktop app or IDE extensions.
- **Hooks** can add a line to the agent's context (`additionalContext`), but receive no usage
  numbers themselves.
- So the bridge is: the status line writes the numbers to a file, a hook reads it. One turn of
  delay. Where there is no status line, only the compaction hook can work.
- Thresholds in the scripts are initial guesses. Report what you saw in the feedback.

Harness features change between versions. If you know a better documented way in the installed
version (`claude --version`), use it, and say so in the feedback.

## Options

1. **Compaction notice** — project level, any surface that runs hooks. `after-compact.sh` on
   `SessionStart` with matcher `compact`. Recommended always.
2. **Status line** — user level (`~/.claude/settings.json`), terminal only, needs `jq`. Shows the
   owner how full the conversation is and the limits; writes the numbers for option 3.
   - If they already have a `statusLine`: do not replace it. Offer to add the writing part (the
     `~/.claude/ctx/` block of `payload/user/statusline.sh`) to their script, or skip.
   - Otherwise copy the script to `~/.claude/statusline.sh` and set
     `"statusLine": {"type": "command", "command": "~/.claude/statusline.sh"}`.
3. **Usage warning** — project level, needs option 2 and `jq`. `ctx-warn.sh` on
   `UserPromptSubmit`: above the threshold it tells the agent to plan a handoff.

Ask the owner which surface they use (terminal, desktop app, VS Code…), say in one line what each
option gives them, and install what applies.

## Installing

- Copy `.claude/hooks/` from the payload for the options chosen; `chmod +x`.
- Merge the matching parts of `payload/project/settings.hooks.json` into the project's
  `.claude/settings.json` (create it if missing; keep what is there).
- **Test before you leave** — feed each script a sample input and check the output:
  - `echo '{}' | .claude/hooks/after-compact.sh | jq .`
  - the status line: pipe a JSON with `session_id` and `context_window` into it; check that it
    prints a line and writes `~/.claude/ctx/<id>.json`;
  - `echo '{"session_id":"<that id>"}' | .claude/hooks/ctx-warn.sh` with values above and below
    the thresholds.
- On Windows without bash, or without `jq`, skip the scripts that need them and say so.

Record in `docs/agent/set.md` what was installed and what was tested.
