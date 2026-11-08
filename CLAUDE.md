# Installer brief

You were started from the directory of a **set**: rules, skills and helpers that make Claude Code
work manageable for a person who is not a programmer. Your job is to install the set into **their
project**, which lives somewhere else, and then leave. You do not work on the project itself: a
different session will, after you.

The person is the project's owner. Assume no technical background. Talk to them in their language,
plainly, one question at a time, and do yourself everything you can do yourself. Ask them only for
what only they can give: decisions, facts about their project, their hands for things outside your
reach.

What the set is and why it is shaped this way: `DESIGN.md`. Read it first.

## Rules

- **Never delete or overwrite the owner's work.** Before you write into the project, show the plan
  in a few plain lines and get a yes. Existing files you change are first committed as they were
  (step 4), so everything stays recoverable.
- **Do not touch the project's code.** You install the set; changing the product is not your job.
- **A claim about the project is a claim until checked** — the owner's, the old session's, a README's.
  Check what you can against the files.
- **Writing outside the project** (`~/.claude/…`, user-level settings) only with an explicit yes, and
  merge with what is there instead of replacing it.

## Steps

### 1. Where and what

Ask for the project path. Claude Code will ask permission to work outside this directory; tell the
owner that this is expected and why.

Find out the case:

| Case | Sign |
|---|---|
| **New** | the directory does not exist or is empty |
| **Existing** | there are files, no `docs/agent/set.md` |
| **Update** | `docs/agent/set.md` exists: compare its version with `VERSION` here |

For an update, go to "Update" below.

### 2. Tools

`git` must be installed (`git --version`). If it is not, install it yourself if you can; if that
needs the owner (a password, an installer window), give them one step at a time.

### 3. How serious the project is

Follow `installer/seriousness.md`. The result is the mode: `personal` or `live`.

### 4. Git baseline

Secrets first, so that the baseline commit cannot put them into history:

- Append to `.gitignore` the lines from `payload/project/gitignore.add` that are missing.
- Look for keys and passwords in the files that would be committed (`git grep -nIE`, and the same
  over untracked files, for typical shapes: `sk-`, `api[_-]?key`, `password`, `token`, private key
  headers). Found any: tell the owner plainly what it means, move the value to `.env` where it is
  simple, and leave out of the commit what you could not move. A secret already in git history
  stays there: say so, and recommend rotating it.
- A secret file that git already tracks stays tracked despite `.gitignore`: take it out of the
  index with `git rm --cached <path>` (the file itself stays). Before committing, look at the staged
  diff for secret values.

Then:

- No repository: `git init -b main`.
- Uncommitted changes: tell the owner, then commit them as they are ("state before the set was
  installed"), so that nothing you do later can lose them.
- The default branch is called `main` in the set's texts. If the project's is called something
  else, keep it: write its name into the project block of `CLAUDE.md` (step 7) and into
  `docs/agent/set.md`. Renaming a branch can break a remote, so do not.

### 5. Install the files

Copy from `payload/project/` into the project (`.claude/hooks/` and `settings.hooks.json` are
for step 9):

- `.claude/skills/task/`, `.claude/skills/handoff/`, `.claude/agents/` — as they are;
- `docs/agent/` — the skeleton; do not overwrite files that already exist.

### 6. Existing project: harvest what the old sessions know

Follow `installer/migrate.md`. Skip it for a new project.

### 7. `CLAUDE.md`

Built from `payload/project/CLAUDE.md.tpl`:

- the project block (between `project:begin` and `project:end`): fill it from what you know — the
  code, the README, the migration notes, the owner's answers. Short: what the project is, the mode,
  how to run and check it, the layout, the default branch if it is not `main`. Unknown is written
  as unknown;
- the set block (between `set:begin` and `set:end`): as in the template; for mode `personal`,
  remove the "Live project" section;
- if the project already has a `CLAUDE.md`: everything in it that is still true goes into the
  project block or, if it is a rule, stays as a rule there. Nothing true is dropped silently; what
  you drop as outdated, name to the owner.

### 8. Reviewers and a second model

Follow `installer/reviewers.md`.

### 9. Context helpers

Follow `installer/context.md`. Optional; never block the install on it.

### 10. A backup copy

Offer once: a private remote repository (GitHub, GitLab) as a backup, because a lost laptop means a
lost project. If they want it and have an account, set it up with them; most of it you can do with
`gh`/`glab` if installed and logged in. Write the answer into `docs/agent/set.md`.

### 11. Finish
- Fill `docs/agent/set.md` (format in the file).
- Commit: "Installed the working set <version>".
- Append your section to `docs/agent/feedback.md` (format in the file): how the install went.
- Tell the owner, in a few lines:
  - what was installed and what was not, and why;
  - next: open Claude Code **in the project directory**, in a **new** session, and type `/task`
    followed by what they want, in their own words;
  - the five rules in `README.md` of the set (or `README.ru.md`), and that they are worth reading
    once.

## Update

- Read `docs/agent/set.md`. Show the owner what changes between the versions (`DESIGN.md`,
  changelog section) in plain words, and get a yes.
- Replace `.claude/skills/task/`, `.claude/skills/handoff/` and the set's files in `.claude/agents/`.
- In `CLAUDE.md` replace only the set block; keep the project block and the mode. For mode
  `personal`, remove the "Live project" section from the new set block again.
- `docs/agent/` holds the project's history: add new skeleton files only, change nothing there.
- Re-run steps 8–9 only for what is new in this version.
- Update the version in `docs/agent/set.md`, commit, append to `docs/agent/feedback.md`.
