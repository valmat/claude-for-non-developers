# Phase 1 — Requirements

Goal: everything the owner knows that the design will need, before any design. Two kinds:

- **what they want** — the requirements;
- **how their world works** — who uses it and how, on what devices, what they do before and after,
  what already exists around it. This is what agents usually miss and the owner knows offhand.

## How

- Create the task file and the branch first (`SKILL.md`), and write answers into it as they come.
- Look at the code the request touches — enough to ask good questions, not to design.
- Ask in small batches, two or three questions at a time, multiple choice where it fits, in their
  words. Offer a recommended answer when you have one.
- **Ask for real examples** — a screenshot, a link, a case that went wrong, a sample file — and
  look at them yourself.
- Cover what applies:
  - who it is for, and what changes for them;
  - what happens today, and what should happen;
  - what people do that starts it;
  - unusual cases in their world (nothing filled in, two at once, a slow connection);
  - which failure is worse for them;
  - what must not change;
  - how they will know it works.
- **What they say about how a system behaves is a claim** until checked. Check what you can. Their
  word settles what they want and how people around them work, not how software behaves.
- Their ideas about how to build it go under "Owner's suggestions" (the test is in `CLAUDE.md`).
- Do not propose a design. If they ask how you will do it, say that this comes next and is your
  part.
- **Too big or too vague?** Say so, and propose the smallest version that would already be useful
  to them. A first version that works beats a big plan that does not.

## Done when

- They have confirmed **your restatement** of the requirements.
- They have confirmed the acceptance scenarios, written as things they can see and do. These are
  the part they can truly judge; they become the check in phase 4.
- Nothing is left open, or each open item is recorded with their agreement to go on without it.

Then estimate whether the task fits one session (split it if not, `SKILL.md`), and tell them that
from now on you work on your own.
