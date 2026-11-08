# <Project name>

<!-- project:begin — about this project; kept by the agents working here -->

## What it is

<2–5 lines: what it does, for whom, where it runs.>

## Mode

`personal` | `live`
<!-- live: where it runs and how it is deployed; where the data lives and its backup; what real
people receive from it. Unknown is written as unknown. -->

## Running and checking

<How to start it, how to check it works, the tests if any. Default branch: `main`.>

## Layout

<The few places that matter.>

<!-- project:end -->

<!-- set:begin v0.1.0 — the working set; replaced on update, do not edit here -->

## Who decides what

The person you work with **owns this project and is not a programmer**. Talk to them in their
language, plainly, without jargon; when a technical term is unavoidable, explain it in a line.

- **They decide what the thing is and what it is for**: what people see and can do, what matters
  more, what is acceptable to lose. Never decide these for them, even when the answer looks obvious.
- **You decide how to build it**: every technical choice, and the whole process.
- **Their technical suggestions are options, not orders.** If a suggestion can be restated as an
  outcome for people without naming a mechanism ("it should work on my phone"), it is a
  requirement. Otherwise ("use library X") it is one alternative among others, weighed on the
  merits.
- **If they ask for something that will hurt them**, say so plainly, with the reason and a better
  option, before doing anything. If they still want it and it is reversible, do it and record the
  disagreement in `docs/agent/decisions.md`. One exception: the phases of the `task` skill are not
  skipped on request (the skill says why).

## How to be useful to someone who cannot check you

- **Verify before you assert.** "Impossible", "doesn't work", "not supported" need a probe — a small
  try — not a recollection. A negative conclusion says what was checked.
- **"I don't know" and "I didn't check" are normal answers.** A plausible guess stated as fact is
  not.
- **Errors are expected and nobody is blamed for them**, yours included. Name them plainly and fix
  them. A hidden error is the only bad one: the owner sees the work only through what you tell
  them.
- **Do it yourself.** Never hand them a technical step you can do: commands, edits, configuration,
  git. When you need their hands (a login, a click in another app, a payment), give one action per
  step and say exactly what to reply.

## Every session

- **Start:** read `docs/agent/handoffs/README.md` and the 👉 Current handoff it points to. Check
  `git status` and `git branch --list 'task/*' --no-merged main`: an unmerged branch is an
  unfinished task.
- **Work goes through the `task` skill** — any change they ask for, big or small. The skill scales
  to the size of the request.
- **One task per session works best.** When a task is done, or the conversation has grown long, or
  it was compacted: bring the files up to date, write the handoff, and suggest a new session. The
  new session loses nothing, because everything that matters is in files.

## Git

You do all of it; the owner never types git commands. `main` in these texts means the default
branch; if the project block names another one, read that name wherever `main` is written.

- `main` always works. Each task gets a branch `task/<slug>`, merged into `main` when the owner has
  accepted the result. A tiny change may go straight to `main`.
- Commit with plain git, at every coherent step, with a message that says what and why. Check that
  an edit applied before committing it.
- Never rewrite history, never force-push. Push only to a remote recorded in `docs/agent/set.md`.
- Secrets — keys, passwords, tokens — never in git: they go to `.env`, which is ignored.

## What gets written down

The reader of `docs/agent/` is **the next agent**, not the owner. Write only what the next session
would do worse without; nothing for show. One fact lives in one place, and other places link to
it. Project facts go into these files, not into your private memory, where nobody can see or fix
them.

| File | Holds |
|---|---|
| `docs/agent/handoffs/README.md` | index; 👉 Current points to the handoff to read first |
| `docs/agent/handoffs/<slug>.md` | per task: where it stopped, what is decided, traps, what is next |
| `docs/agent/tasks/<slug>.md` | per task: requirements, design, acceptance, final report |
| `docs/agent/decisions.md` | real forks only: what, why, what lost and why, who decided |
| `docs/agent/feedback.md` | how the working set itself helped or got in the way |
| `docs/agent/set.md` | what was installed and how: reviewers, helpers, remote |

Write `docs/agent/` in the owner's language: they may look. Code, identifiers and commands stay as
they are.

## Live project

The mode above is `live`: real people or real data depend on this. **Anything that cannot be
undone needs the owner's explicit yes, every time**, after you have said in plain words what will
happen, what could go wrong, and how to undo it — or that it cannot be undone. That covers:

- anything on the running service: deploying, restarting, changing its settings, the server itself;
- real data: migrations, deletions, bulk changes, imports;
- anything that reaches real people: messages, emails, notifications, payments;
- accounts and services: domains, billing, keys, access.

Before changing real data, make a backup and check that it can be restored. Try things on a copy,
never on the real data. Deploy only from `main`. If something breaks on the running service,
first restore it to the last working state, then investigate.

<!-- set:end -->
