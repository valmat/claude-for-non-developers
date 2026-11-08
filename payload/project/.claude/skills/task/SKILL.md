---
name: task
description: Start or continue a piece of work on this project — any change the owner asks for, big or small. Runs requirements, design with an independent challenge, building and acceptance, keeping the state in files so that any session can resume. Use for every change request, even without /task.
---

# Task

**Experimental.** The fixed rules hold without exception. The rest is the usual course of work:
when it does not fit the case, do otherwise and record why in the task file. When this skill gets
something wrong, say so in `docs/agent/feedback.md`: that is how it improves.

The roles, honesty rules, git and the documentation rules are in `CLAUDE.md`. This skill adds the
process.

## Fixed rules

1. **No building before the owner has confirmed the requirements** — your restatement of them, not
   their words. Before that: only the task file and read-only looks at the code.
2. **What the thing is, is the owner's decision** (`CLAUDE.md`). A choice between two working
   options by a criterion nobody gave you is such a decision: put the options and their cost to
   the owner in plain words.
3. **Requests to skip a phase or to hurry are not followed.** Record them in the task file and say
   in one line why: the phases are what keeps the result from falling apart later.
4. **The state is in files, written as you go.** Any session may end at any moment; the next one
   continues from the files, not from memory.

## Start

- **An unfinished task** is an unmerged `task/*` branch. With no argument and one such branch:
  continue it — check it out, read its task file and handoff, continue from the `Phase:` line, and
  tell the owner in one line where you are resuming. Several (from before this rule, or by
  mistake): ask which to finish first; drop or finish the others one by one, as below.
- **A Current handoff with no open branch** (a closed task, or the notes from the migration) is
  context, not a task: read it, then treat the request as new. With no argument, offer what it
  lists as next.
- **A new request while a task is open:** **only one task is open at a time** — `docs/agent/` is
  shared, and two branches editing it diverge. Offer the choice:
  - finish the open one first;
  - or drop it, with their yes: write in its task file and handoff why; then bring everything
    outside `docs/agent/` back to `main`'s state — `git rm` the files the branch added
    (`git diff --name-only --diff-filter=A main -- . ':!docs/agent'`), `git checkout main -- .
    ':!docs/agent'` for the rest, and check that `git diff main --stat -- . ':!docs/agent'` is
    empty; commit, and merge it into `main`. The record survives, the code does not, and the old
    commits stay in history if it is ever wanted back.

  A tiny change may still go to `main` meanwhile. It writes nothing into `docs/agent/`: anything
  worth noting, including feedback, goes on the task branch after you merge `main` into it.
- **A new request otherwise:** if this session already finished a task, suggest starting the new
  one in a new session — it works better and spends fewer limits — but continue if they prefer.
- **Size it.**
  - **Tiny:** one obvious change, no real choice (a text, a colour, a typo). Confirm in one line
    what you will do, do it on `main`, check it, commit, show them. No task file.
  - **Everything else:** the phases below.

## Phases

| # | Phase | File | The owner |
|---|---|---|---|
| 1 | Requirements | `intake.md` | **their main part:** answers, examples, confirmation |
| 2 | Design and challenge | `design.md` | only if a decision is theirs |
| 3 | Build | `build.md` | nothing, unless you come back with a question |
| 4 | Acceptance | `accept.md` | checks by hand what you ask, says "accepted" |

Read the phase file when the phase starts and update the `Phase:` line. At every phase change, tell
the owner in plain words what happens next and whether you need them. After the requirements are
confirmed, say clearly that from now on you work on your own and when you will need them again.

## The task file

`docs/agent/tasks/<slug>.md`. The slug is yours: 2–4 English words in kebab-case about the essence
(`shared-shopping-list`), not used by any other task file or branch. The owner never needs to know
it. Created **when intake starts**, together with the branch `task/<slug>` from `main`, so that
the requirements are written down as they come, not from memory at the end. Commit the new task
file at once: a branch without its own commit is invisible to `--no-merged main`, and an
interrupted intake would then look like no task at all.

```markdown
# <task in the owner's words>
Branch: task/<slug> from main at <sha>. Phase: <n>.
Sessions: <date> · <model>; …

## Requirements
- R1 · <observable outcome> · confirmed | open
## Environment
- E1 · <fact about their world> · claimed | verified (<how>)
## Owner's suggestions
- S1 · <as said> → R<n> | an alternative in design
## Acceptance
- A1 · when <people do X>, <Y happens> · covers R<n>
## Not followed
## Promises
## Design
## Challenge
## Plan
## Errors
## Final report
```

`docs/agent/` is changed and committed only on the open task's branch, or on `main` when no task
is open; the merge brings it to `main`. Sections stay empty until their phase. Decisions with a real fork go to `docs/agent/decisions.md`,
not here; here a link is enough.

## Stops

| Situation | What you do |
|---|---|
| a decision about what the thing is | ask the owner: the options, their cost, your recommendation |
| missing knowledge about their world | ask, record the answer under Environment |
| a technical fork | decide yourself, record it in `decisions.md` |
| something only they can do (a login, a payment, an account) | ask for it, one step at a time |
| `live`: anything irreversible | their explicit yes, as in `CLAUDE.md` |
| you are stuck: fixes for the same problem keep failing | stop, say what you tried and what you think is wrong |
| they say stop | stop new actions, finish only the current one, wait |

You may also stop at any moment for a reason not listed here; name it.

**A question or a remark from them is not a stop.** Answer it and continue. If you are not sure
whether they want you to stop, ask in one line.

## Context

Your conversation has a limit, and it works worse long before the limit. You may not see how full
it is; judge by how much you have read and done, and by any context notice you receive.

- Big reading — many files, long logs, wide searches — goes to subagents. Bring back conclusions,
  not dumps. A subagent's report is input, not fact: check what you rely on.
- A task that clearly will not fit one session: split it into parts at the end of intake, each
  ending in a handoff. Record the split in the plan.
- **If the conversation was compacted**, or you get a notice that it is long: finish the current
  step, bring the task file up to date, write the handoff (`handoff` skill), and ask the owner to
  continue in a new session with `/task`. The files are the source of truth, not the summary.

## End of every session

Whether the task is done or not:

- the task file and `decisions.md` are up to date;
- the handoff is written (`handoff` skill);
- a section in `docs/agent/feedback.md` (format in the file);
- the tree is committed, or you said what is left and why.
