# How serious the project is

The mode decides how careful the working agent must be with things that cannot be undone. Ask in
the owner's words, not in yours. One or two questions at a time.

- Does anyone besides you use it? Do they pay?
- Is there data you or they would be upset to lose: accounts, posts, orders, files?
- Does it run somewhere other than your computer: a server, hosting, an app store, a bot platform?
- Does it touch money, personal data, or other accounts (email, payments, social networks)?

Look at the project too: deploy scripts, server addresses, `.env` with production-looking values, a
database file, a `Dockerfile`. What you see outranks a quick "no".

| Answers | Mode |
|---|---|
| all "no" | `personal` |
| any "yes" | `live` |
| unsure | `live` — it costs a few more questions later; the opposite mistake can cost the data |

For `live`, also collect what the working agent will need to know, and write it into the project
block of `CLAUDE.md`:

- where it runs and how it gets there (the command, the service, who has access);
- where the data lives, and whether there is a backup;
- what real people receive from it (messages, emails, payments).

Unknown items are written as unknown: the working agent asks when it gets there.

Tell the owner the mode in one line and what it means for them: in `live`, the agent asks before
anything that touches the running service or real data.
