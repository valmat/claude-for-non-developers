# A working set for Claude Code, for people who don't program

**English** · [Русский](README.ru.md)

You are building something with Claude Code — a site, a bot, an app — and you are not a
programmer. At first it goes great. Then, a few weeks in, the agent starts forgetting what was
agreed, breaks what used to work, and the project gets harder and harder to steer.

Usually the cause is the same: everything lives in one long conversation. When it gets too long,
Claude Code quietly compresses it, and details disappear. Nobody notices until something breaks.

This set fixes that with a simple discipline that Claude keeps for you:

- **every task is its own conversation**, and everything important is written into files in your
  project, so a new conversation picks up exactly where the last one stopped;
- **before building, Claude asks what you actually need** and checks its understanding with you;
- **its plan is challenged** by an independent reviewer before any code is written, because you
  can't check it yourself;
- **every step is saved in git**, so anything can be undone.

You don't need to learn any of this. Claude sets it up and follows it.

**Status: experimental.** It works in the author's projects; with yours it is being tried now.
Your feedback is how it gets better (see below).

## Install

You need [Claude Code](https://claude.com/claude-code) installed and working.

1. Download this set (`git clone` or the green **Code → Download ZIP** button on GitHub) into its
   own folder — **not** inside your project.
2. Open a terminal in the set's folder and start `claude`.
3. Tell it where your project is, in your own words, for example:
   *"Install into ~/projects/my-shop"*. A new project works too — give a folder name.
4. Answer its questions. If you have been working on the project in one long conversation, it will
   recover what that conversation knows before you move on.

It will ask permission to work in your project's folder: that is expected.

## Use: five rules

1. **Open Claude Code in your project's folder** (not the set's) **and start every task with
   `/task`** and say what you want in your own words:
   `/task the family should be able to share one shopping list`.
   To continue an unfinished task, type just `/task`.
2. **One task — one conversation.** For the next task, open a new conversation (`/clear`, or a new
   window). Nothing is lost: it is all in files.
3. **The questions at the start matter most.** Answer them carefully, give real examples
   (screenshots, links, a case that went wrong). "I don't know" is a good answer; a guess presented
   as a fact is not.
4. **When Claude suggests a new conversation — open one.** It has written down everything first.
5. **When it asks you to check something, do exactly the steps** and say what you actually saw,
   even if it seems wrong or unimportant.

While it works, don't edit the project's files yourself. Never paste passwords or keys into the
chat: Claude will tell you where they go.

## When something feels off

If Claude says something can't be done, is very sure of itself, or asks you to do technical things
by hand, these phrases help:

- *"What exactly did you check?"*
- *"Try a small test before saying it's impossible."*
- *"If it were your decision, what would you choose and why?"*
- *"Can you do this step yourself instead of me?"*

## Feedback

After each session, Claude adds a few lines about how the process went to
`docs/agent/feedback.md` in your project — only about the process, nothing about your project.
If you'd like to help, send that file to the author or paste it into an
[issue](../../issues). Nothing is sent anywhere by itself.

## Update

Get the new version of the set (`git pull`, or download again), start `claude` in its folder and
say *"Update my project ~/projects/my-shop"*.

## More

- [DESIGN.md](DESIGN.md) — why the set is built this way.
