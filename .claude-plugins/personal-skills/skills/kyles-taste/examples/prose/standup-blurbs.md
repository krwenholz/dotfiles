# Slack — daily standup blurbs

Internal register, at its most compressed. Every bullet is a link plus one description, so the
description has nowhere to hide. The best sample of how short Kyle goes when the format forces it.

Names, repos, ticket IDs, and meeting titles below are placeholders. Links stripped for
readability; in the real post every item is a markdown link.

---

### Yesterday
- api-gateway #367 - This should fix api-gateway's startup failures!
- infra #1178 - Merged. PROJ-300 is done, the old IAM role is fully gone.
- deps-config #45 - Turned out we should just fix the bot's settings rather than work around it
  with a cron job :facepalm:
- Cloud agent build caching - Ana asked why startups were slow, turned out builds weren't
  actually caching. ~3 minutes down to ~10 seconds.
- Cloud agent repo routing help entry - Answered Ben on how cloud agents pick a repo, and wrote
  it up in the help doc so I only have to explain it once.
- All Hands, Eng Exchange, Projects Review - Attended, and picked up a good orchestration
  conversation with Cleo out of Projects Review.
- New-hire onboarding - Mostly wrapped. A few stragglers left.

### Today
- New-hire onboarding - Killing off the last of it today.
- TEAM-104 - Giving Ana a real review. The web repo's getting cloud agents, which is great to
  see spreading.
- PROJ-402 - Manual cross-repo run to get a first read on the data.
- monorepo #48867 - Looks like this got reviewed, so I'll try to get it merged!

Happy Friday!

---

More blurbs, from older standups:

- "Finally got a dev sandbox set up."
- "I'm a just gonna copy Ben's work."
- "It mostly makes sense, but it's also kinda black magic DBA territory."
- "Unless someone else wants to grab it, I'll try to get to pg_repack next week."
- "Some PRs I'm forgetting."

---

## What to copy

- **Fragments carry most of it.** "Merged." "Mostly wrapped. A few stragglers left." Dropping the
  subject is the default, not a shortcut.
- **Length tracks how much there is to say.** A mechanical merge gets one word. A judgment call
  gets a sentence. Nothing gets padded to match its neighbors.
- **Say what happened, not what the diff did.** "This should fix api-gateway's startup failures!"
  over "Switched the package source."
- **Numbers when there's a number.** "~3 minutes down to ~10 seconds." The tilde stays.
- **Name whoever prompted the work.** "Ana asked why startups were slow", "Answered Ben",
  "Giving Ana a real review." Credit and context in the same two words.
- **The correction is the finding.** "Turned out we should just fix the bot's settings rather
  than work around it with a cron job :facepalm:" — what he learned, not what he shipped.
- **Incompleteness stated flatly.** "A few stragglers left." "Some PRs I'm forgetting." Never
  rounded up to done.
- **Exclamation points land on small wins**, not on the big items.
- **Slang does real descriptive work.** "kinda black magic DBA territory" is the most accurate
  available description, not decoration.
- **Volunteer the handoff.** "Unless someone else wants to grab it, I'll try to get to pg_repack
  next week."
- **Sign off with the day.** "Happy Friday!"
