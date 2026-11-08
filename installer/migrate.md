# Harvesting an existing project

Projects worked on without the set usually live in one long session. What it knows — decisions,
agreements, dead ends, unfinished work — is in that conversation, not in files. Get it out before
the owner leaves that session behind.

The old session may be deep in a degraded context, so its answers are **claims**. The ground truth
for what the owner asked and decided is their own messages, which survive in the transcript
regardless of compaction.

## 1. Find the sessions

Transcripts are in `~/.claude/projects/<dir>/*.jsonl`, where `<dir>` is the project's absolute
path with every `/` (and other non-alphanumeric characters) replaced by `-`. List that directory;
if the name does not match, look for the closest one.

- No transcripts: the owner may have worked elsewhere (the claude.ai web chat, another computer).
  Ask; if so, go to "Fallback".
- Record the list before your first fork: every fork adds a new transcript here, and the forks are
  then the most recent. Always resume the **original** id.
- Several: the long-running one is usually the largest and the most recent. If unsure, show the
  owner each candidate's date, size and first message, and let them pick. There may be more than
  one worth harvesting.

## 2. The owner's own messages

Extract them into a file **outside the project** (your scratchpad), never committed:

```bash
jq -r 'select(.type=="user" and (.isMeta|not) and (.isCompactSummary|not))
  | .message.content
  | if type=="string" then . else (map(select(.type=="text") | .text) | join("\n")) end
  | select(length>0)' <transcript>.jsonl > owner-messages.txt
```

Skim it (a subagent if it is long): what they asked for, what they decided, what they complained
about, what was left open. This is your checklist for step 3.

## 3. Interview the old session

Tell the owner first: this reads the whole old conversation once, which uses a noticeable part of
their subscription limits. Get a yes.

Ask it through a **fork**, so the original session stays untouched, with tools off, from the
project directory (sessions are found by directory):

```bash
cd <project> && claude -p --resume <session-id> --fork-session --tools "" < prompt.txt
```

Check the flags against `claude --help` of the installed version first. Save every answer to a
file in your scratchpad, not only to the terminal. Start with a one-line probe ("Reply with the
first thing the owner asked you in this conversation") with a short timeout, to see that the fork
works; if it is refused or fails, go to "Fallback". Then send the prompt below. Use a
generous timeout: a large session takes minutes to load.

Compare the answer with the owner's messages. For every item on your checklist that the answer
misses or contradicts, ask a follow-up in a new fork of the same original session. Stop when the
gaps are closed or the answers stop adding anything; usually two or three rounds.

```text
This project is moving to a new way of working: from now on, every session starts fresh and reads
the project's state from files. You are the only one who knows the history, so write it down for
the next agent. Write in English, concisely, only what is NOT visible from the code itself:

1. What the project is, for whom, and where it runs.
2. Decisions that were made and why — especially ones the owner made. Mark which were the owner's.
3. Things that were tried and rejected, and why.
4. Agreements and preferences of the owner about how to work.
5. Unfinished work: what was in progress, what was promised, what is known to be broken.
6. Traps: things that break easily, odd setup, credentials and where they come from (never the
   secret values themselves).
7. What you are unsure about. Mark guesses as guesses.

If parts of this conversation were summarised and you lost details, say so instead of filling in.
```

## Fallback: the owner asks the old session

If there is no transcript, or the fork does not work, give the owner the prompt above, adding at
the end: "Write it to `docs/agent/migration.md` in the project." They paste it into the old
session. Then check that file against the owner's messages (if you have them) and against the code,
and ask the owner about what is missing.

## 4. Put it where it belongs

Do not keep a migration dump. Distribute:

- what the project is, how it runs, the stack → the project block of `CLAUDE.md`;
- decisions → `docs/agent/decisions.md`, each with "who decided" and the source ("from the old
  session, owner's message on <date>" or "old session's claim, unverified");
- unfinished work, traps, open questions → a handoff `docs/agent/handoffs/migration.md`, set as
  👉 Current in the index; the next session starts from it;
- claims you could check against the code: check, and say so; the rest stays marked unverified.

Tell the owner in a few lines what was recovered and what looked lost or contradictory.
