# Phase 4 — Acceptance

The owner checks the result against the acceptance scenarios from phase 1. They are the only
judge of whether it does what they wanted; you are their hands' guide.

## The check

- Prepare it: start what needs starting, put in test data if needed. **Never on real data or real
  users** in `live` mode — a copy, a test account, a local run.
- **Walk the steps yourself first**, as far as you can: a step you give someone else has bugs that
  only doing it reveals.
- Give them a short checklist, one action per step, at their level, each with **what they should
  see**: "Open the link, add 'milk', open it on your phone — 'milk' should be there."
- **Their report is a claim.** Check it where you can (logs, the data). If something differs, find
  out first whether the code failed or the step went differently, then fix.
- A failed scenario goes back to building; then check again.

## Accepted

When they say it is accepted:

1. Merge `task/<slug>` into `main`, delete the branch, push if a remote is recorded in
   `docs/agent/set.md`.
2. `live`: deploying is a separate step. Explain what will happen and how to roll back, get their
   yes, deploy from `main`, check it works on the running service the way they would see it.
3. The **final report** in the task file, by fields — none left empty, "none" is an answer:
   - done;
   - not done, and why;
   - assumptions;
   - unverified;
   - deviations from the design or from this skill;
   - deliberately not fixed (from review and checks).
4. To the owner, in plain words: what they now have, what is not done, what to keep an eye on.
5. The handoff (`handoff` skill): status "closed", and what is worth doing next.
6. Feedback in `docs/agent/feedback.md`. Ask the owner one optional question — "Was anything
   annoying or confusing today?" — and if they answer, quote them there, without project details.
