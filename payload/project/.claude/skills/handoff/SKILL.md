---
name: handoff
description: Write the handoff for the next session — what is not visible from the code and the task file — and point the handoff index at it. At the end of every working session, when the conversation got long or was compacted, or when the owner wants to stop.
---

# Handoff

You are writing to **the agent of the next session**, who starts with nothing but the files. The
owner may look, but is not the reader.

Write what is **not visible** from the code, the task file and `decisions.md`: where exactly you
stopped, what is settled and must not be reopened, the traps. Do not retell them; link. A fact that
a 30-second read of a file gives is not needed.

## Where

- A task: `docs/agent/handoffs/<slug>.md`. If it exists (the task took several sessions), **append**
  a dated section; do not rewrite earlier ones.
- Work outside a task (a tiny change, a question session) normally needs no handoff. If something
  must survive anyway, append it to the Current handoff as a dated section — on the open task's
  branch if there is one, never on `main` while a task is open.
- After writing, update `docs/agent/handoffs/README.md`: 👉 **Current** is the handoff the next
  session must read first — this one. The previous Current moves to History as one line: slug,
  dates, status, one phrase. Exactly one Current.

## Before writing

Run the project's checks and record the actual result, not from memory. Red is not hidden.

## Structure

`# <task in the owner's words>` and a line: for whom, as of when. For an appended section:
`## Session <date>`.

1. **Status** — phase; branch; checks with their real result; closed or not; the next concrete
   step.
2. **Settled, do not reopen** — the decision, why, who decided, and what would justify reopening it.
   Usually links to `decisions.md`; here only what the next session would otherwise reopen.
3. **Not done, and why** — deliberately postponed apart from forgotten.
4. **Assumptions** — what the work stands on but nobody checked.
5. **Unverified** — including review fixes that did not get their own round.
6. **Traps** — what breaks and how to avoid it, with `file:line` found by `grep -n`, not recalled.
7. **The owner** — what they are waiting for, what was promised to them, how they prefer to work.
   Their position only with a quote or a source; otherwise it is your guess, so say so.

Sections 3–5 are never left empty: content or "none". Silence cannot be told from forgetting.

Short is right. A handoff that has grown long is retelling the code or the task file.

## After

Commit the handoff and the index. Tell the owner in one or two lines that everything is saved and
what the next session will start with.
