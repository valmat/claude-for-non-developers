# Phase 2 — Design and challenge

The design is yours. Nobody on the owner's side can review it, so it gets an independent
challenge instead.

## Design

- **Read the code the design touches.** Wide reading goes to a subagent.
- **Probe, don't assume.** Settle every uncertain fact about a library, a service or the data with
  a small try. A probe that writes anywhere outside the project, or spends money, needs the owner's
  yes first.
- **Promises.** Write under "Promises" the one to three things this change must never break, in
  plain words: "a list the family already has is never lost", "without the new setting everything
  works as before". They decide when review is done and what counts as minor.
- **Alternatives.** At each real fork list the realistic contenders, the owner's suggestions
  included. Defend each as if it were yours, pick the one that wins on the logic, record in
  `decisions.md` why each lost. A contender nobody would choose is not one.
- **Price every contender**, not only the winner:
  - time and memory where it runs, under that machine's or hosting plan's limits;
  - money: running costs, paid services, per-use fees;
  - what can be lost: data, messages, work in progress — and what the new path loses that the old
    one had;
  - security and privacy: who can see or change what;
  - **who maintains it**: the owner cannot fix it by hand, so prefer what fails loudly, recovers
    by itself and has fewer moving parts;
  - how hard it is to change later.
- **Simple first.** Choose the most complex option only when the requirements demand it. The
  owner pays for every moving part for as long as the project lives.
- **Plan:** chunks, each a coherent piece a reviewer can see whole, each with its own check. Do not
  split finely.

Write the design and the plan into the task file.

## Challenge

Before building, the design goes to the `challenger` subagent.

- Give it the paths: the task file, `CLAUDE.md`, and the code the design touches. **Do not tell it
  your conclusions or what to look at**: its value is a view that does not share yours.
- For each finding: check it, then accept it or answer with your evidence (a probe, `file:line`).
- Continue **the same subagent** (`SendMessage` to it) with your answers, so that it can concede or
  hold its ground. Agreement you reach this way is usually right; that is why the exchange matters.
  If continuing it is not possible in this setup, start a new `challenger` with its findings and
  your answers verbatim.
- Still disagreeing on something that matters: take it to the owner as two options with their cost,
  in plain words, with your recommendation and its.
- **A second model.** If `docs/agent/set.md` records a challenge command for another provider, run
  the same challenge there as well, with the same exchange. Different model families have
  different blind spots.
- Record under "Challenge": what was found, what changed, what was rejected and why.

Skip the challenge only for a task without a real fork; record that it was skipped.

## Done when

- The task file has the promises, the design, the challenge outcome and the plan.
- Any decision that is the owner's has been put to them and answered.
- They got a plain summary of what will change for people. Nothing technical for them to approve.
