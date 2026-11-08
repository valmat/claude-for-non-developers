# Reviewers and a second model

The working agent gets its work checked twice: a **challenge** of the design before building, and
a **review** of the code before it is accepted. Both work out of the box with Claude subagents
(`.claude/agents/challenger.md`, `.claude/agents/reviewer.md`). Everything here is an optional
upgrade. Record every answer in `docs/agent/set.md`.

Two things are the owner's call, not yours, and are asked explicitly:

- **Money.** Their own pocket, not a company's. A hobby project does not need paid reviews.
- **Where their code goes.** Another provider means another company sees the code.

Default for both: no.

## The `review-2nd` skill

Independent reviews of the diff by several reviewers with a clean context. Look for it in this
order: `payload/optional/review-2nd/` in this set, then `../claude_non_tech_skills/review-2nd/`
next to this set. Not found: skip this section.

If found:

1. Copy it into the project's `.claude/skills/review-2nd/`.
2. `git -C <project> config review2nd.reviewers claude` — only Claude, through the owner's
   subscription, nothing extra to pay. This lives in `.git/config`, not in the repository.
3. Run `<project>/.claude/skills/review-2nd/scripts/review.sh --list-reviewers` from the project.
   For each other provider marked **available**, ask the owner, in plain words:
   - providers on an API key (`openai`, `deepseek`): **paid from their own account, per use**. A
     working session with several review rounds can cost around 15–30 USD on OpenAI. Their code is
     sent to that company;
   - say what it gives: a reviewer from a different model family catches what Claude reviewers
     share as blind spots.

   On a yes: add it to `review2nd.reviewers` (`git config review2nd.reviewers "claude openai"`).
4. Run `review.sh --dry-run` once in the project to see that it works.

## A second model for the challenge

If the owner has another subscription with a CLI — `codex` (ChatGPT) or `gemini` — the design
challenge can also go to it. It costs no money on top, but uses that subscription's limits, and
the code is read by that provider. Ask.

On a yes, **find a working command yourself** and record it in `docs/agent/set.md`, exactly as it
ran. It must be read-only and non-interactive, run from the project directory, and allow a
follow-up in the same conversation. Starting points, to check against `--help` of the installed
version:

- Codex: `codex exec -s read-only "<prompt>"`; a follow-up: `codex exec resume <id> "<reply>"`
  (the id is printed in the output, or use `--last`).
- Gemini: `gemini --approval-mode plan -p "<prompt>"`; a follow-up: `--resume latest`.

Test it: one prompt that asks it to read a file in the project and quote its first line, then one
follow-up that refers to the answer. Both must work, and it must not have changed any file
(`git status`). If it does not work within a few tries, record "not set up" and why.
