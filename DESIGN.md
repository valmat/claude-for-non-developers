# Design of the working set

For whoever maintains the set, and for the installer agent. Agents working in a project do not
read this file.

**Status: experimental, v0.1.0.** Built from one maintainer's practice with coding agents across
several projects: long-running work through handoffs, a coordinator/implementer split, and a
process that let non-developers ship features through Claude without the maintainer. What carried
over is stated as a principle; what is new here is marked as a hypothesis.

## The problem

People without an engineering background increasingly build real things with Claude Code: from a
personal hobby to services with paying users. They tend to fail the same way: one endless session
per project, nothing written down, and the agent "remembers" everything inside that session. When
the conversation is compacted — at an arbitrary moment, invisible to both sides — or simply grows
too long to work well, the project loses its memory. Control is lost and chaos follows.

The second cause: requests stay vague, nobody challenges the design, and the agent fills the gaps
with product decisions of its own.

## Principles

1. **A session is disposable; the memory is in files.** Everything that matters is written as the
   work goes, so any session can end at any moment and the next continues from the files.
2. **Roles by competence.** The owner decides what the thing is and what it is for; the agent
   decides how to build it. The owner's technical suggestions are options, not orders: if one can be
   restated as an outcome for people without naming a mechanism, it is a requirement; otherwise it
   is one alternative among others.
3. **Requirements before design, design before code.** The owner confirms the agent's restatement
   of what they want and the acceptance scenarios in their own terms. Everything after is built on
   that.
4. **An outside view replaces the review nobody on the owner's side can do:** an independent
   challenge of the design, and an independent review of the code.
5. **Honesty is a mechanism, not a declaration.** Errors are normal and not blamed; "I don't know"
   is an answer; claims are verified by probes; negative conclusions list what was checked; the
   owner's harmful wishes are argued against before they are followed.
6. **Write only what the next agent needs.** The owner will not read the agent's notes. One fact,
   one place. No documents for show.
7. **Do it yourself.** The agent never hands the owner a technical step it can take.
8. **The core works everywhere.** Skills, `CLAUDE.md` and files work in every Claude Code
   surface. Anything surface-specific (status line, hooks) is an optional extra.

## Decisions

**The installer is a separate agent, started from the set's directory.** The set's `CLAUDE.md`
is the installer's brief, so the owner only needs to start `claude` there and name their project.
The agent that will work in the project is a different, fresh session. People cannot be expected
to configure this correctly; an agent can.

**Harvest the old session instead of trusting it.** For an existing project, the installer
interviews the old long session through a fork (`--resume … --fork-session`, tools off), so the
original stays untouched, and checks the answers against the owner's own messages extracted from
the transcript: those survive compaction and context rot. Fallback: the owner pastes a prompt into
the old session. *Hypothesis:* the fork route has not been exercised on a real project yet.

**Sequential roles, not parallel sessions.** One task runs through requirements → design with
challenge → build → acceptance. Rejected: a live coordinator session talking to an implementer
session. It works for an engineer, but its mechanics (two sessions, messaging between them, a
shared working tree, an entry phrase) are exactly where a non-developer loses control.

**The challenger is a subagent of the designing agent, not a separate session.** Agents that argue
usually converge, and the view they converge on is usually right. A challenger in a separate
session has nobody to argue with, and if it is wrong, the owner cannot tell. As a subagent with a
fixed role (`.claude/agents/challenger.md`, written by the set, not by the agent being
challenged), it answers the designer, who replies with evidence; the same subagent is continued
until they agree or the disagreement goes to the owner as two options with their cost. A second
model family (Codex, Gemini) can challenge too, through its CLI, if the owner has that
subscription.

**The scale is derived, not asked.** "What does a failure cost?" gets a random answer from someone
who cannot price technical risk. The agent writes one to three promises in plain words from the
requirements; they decide when review is done.

**Building is autonomous; acceptance is the owner's.** The owner cannot review a diff, so there is
no pause between chunks. Their gate is the hand check against the acceptance scenarios, with
one-action steps and a visible sign of success, and their report is verified where possible.

**One `task` skill instead of a separate autonomous-mode skill.** Fewer things to remember: one
command starts or continues any work. The skill scales to the request: a tiny change skips the
phases.

**Two modes: `personal` and `live`.** Projects range from a hobby to a service with paying users
on a rented server. In `live` mode anything irreversible (the running service, real data, real
people, accounts) needs the owner's explicit yes every time, with a backup and a way back. When in
doubt, the installer picks `live`.

**Git is mandatory and entirely the agent's.** It is the owner's undo button, not a formality.
`main` always works; one branch per task; merge on acceptance. No gitflow: it solves problems of
teams, not of one owner with an agent. No house commit style. Optional remote as a backup.

**Handoffs: one file per task plus an index with a cursor.** A new session reads the index and the
current handoff only. A single rewritten handoff was considered and rejected: it either grows or
loses history. Unmerged `task/*` branches are the list of unfinished tasks.

**One open task at a time.** `docs/agent/` is shared by all tasks; two open branches editing it
diverge and conflict on merge. A task that is no longer wanted is dropped rather than parked: its
code is reverted, its record is merged into `main`, so nothing learned is lost.

**Reviewers: Claude only by default.** `review-2nd` if installed, else a clean-context `reviewer`
subagent. Other providers are offered only after asking, because they cost the owner's own money
(an API key, around 15–30 USD per working session with several rounds on OpenAI) or their
subscription limits, and because the code goes to another company.

**Context monitoring is best effort.** The status line receives the context usage; hooks receive
none but can add context. The status line writes the numbers to a file, a hook reads it and warns
the agent; a `SessionStart` hook on `compact` tells the agent that it was compacted. The status
line exists only in the terminal. The thresholds are guesses. The installer decides what applies
and the feedback collects what actually works. *Hypothesis.*

**Feedback is written to be sent, and never sent automatically.** Each session appends a section
to `docs/agent/feedback.md` about the process only, with no project content. The owner may send
the file to the authors; nothing leaves the machine on its own.

**Language.** Everything for agents is in English. The agent talks to the owner in their language
and writes `docs/agent/` in it, so that they can look. The README is in English and Russian.

## Not in the set

- `auto-commit` and house commit styles: no corporate requirements here.
- `review-2nd` is distributed separately for now (`claude_non_tech_skills`), and installed when
  found next to the set.

## Open questions

1. The fork-based harvest of an old session: works on a large real session? How much of the
   limits does it cost?
2. Context thresholds (300k / 500k tokens, 60 % / 80 %): calibrate from feedback.
3. Does the challenger subagent catch what matters in practice — for example, a design that does
   not fit the memory of where it runs?
4. A `codex` provider for `review-2nd`: a review from another model family through a subscription
   many owners already have, instead of a paid API key.

## Changelog

- **0.1.0** — first version.
