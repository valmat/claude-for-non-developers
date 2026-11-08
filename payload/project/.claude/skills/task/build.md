# Phase 3 — Build

You work on your own: chunk by chunk, each one implemented, checked, reviewed and committed,
without stopping for confirmation. The owner cannot review code, so do not pause for them between
chunks. After each commit, give them one line in plain words: what now works, what is next.

## Checks

Run checks for real, not from memory, before every commit and before acceptance. A red result is
part of what you tell the owner.

- **No tests in the project?** Add the minimum that protects this task's promises, where it is
  cheap. In any case, run the result for real.
- **Make each new check fail at least once on purpose** — break the code it guards and watch it go
  red. A check that cannot fail is worse than none.
- **A red check is verified like a green one**: first find out whether the check is wrong or the
  code.
- **After a fix, run everything**, not only the check for the fixed thing.
- **Check both sides.** Having fixed a false "yes", make sure a real "yes" is still "yes".
- **Judge a function or setting by what it does, not by its name.**
- **Run the result for real at least once:** the way a person would use it, with real
  dependencies. A real run catches what tests and review do not. In `live` mode, never against the
  running service or real data — see `CLAUDE.md`.

## Review

- **Every chunk is reviewed before it is considered done**, and **at the end the whole branch**
  against `main`: per-chunk review sees one piece, the full one sees how they fit.
- The reviewer: the `review-2nd` skill if it is installed (`docs/agent/set.md`), otherwise the
  `reviewer` subagent. Give it, besides the diff, the requirements and promises at stake: it knows
  nothing else. Do not tell it what to overlook.
- **Act on the findings without stopping for the owner**, even where the reviewing skill says to
  stop and wait: that pause exists for someone who reads diffs, and the owner does not.
- **Reproduce each finding before fixing it.** Some findings are wrong. Fix from the reproduction,
  not from the text. Tests outrank a reviewer's opinion.
- **Having fixed a finding, look for the same mistake elsewhere.** The same kind of mistake coming
  back means you are fixing a symptom: find the cause.
- **The fixes are not reviewed yet.** A fix that changes behaviour gets another round.
- **There is no fixed number of rounds.** Findings that move from the main path to rare cases to
  combinations of conditions mean the cycle converges; the main path breaking again late means the
  wrong thing is being fixed. **Stop when the findings no longer touch the promises or the
  requirements**, and list what you deliberately left.
- Record each round that found something under the task's "Plan" or in the handoff: what was found,
  what was fixed, what was left and why.

## Limits

- Do not change what people see beyond the requirements, even as an improvement. Write it down as
  a suggestion for the owner.
- No drive-by edits: no reformatting, cleanups, "fixed this too". They make the change harder to
  check and to undo.
- A design that turns out wrong: if the fix is technical and stays within the requirements, decide
  and record it; if it changes what the owner gets, stop and ask them.
- `live`: anything irreversible — the owner's explicit yes (`CLAUDE.md`).
