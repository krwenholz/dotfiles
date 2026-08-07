# Slack — daily standup blurbs

Internal register, at its most compressed. Every bullet is a link plus one description, so the
description has nowhere to hide. The best sample of how short Kyle goes when the format forces it.

Links stripped below for readability; in the real post every item is a markdown link.

---

### Yesterday
- mx-authorization #367 - This should fix mx-authorization's startup failures!
- atmos-infra #1178 - Merged. BUILD-300 is done, old Cursor role is fully gone.
- mx-renovate-shared #45 - Turned out we should just fix Renovate's settings rather than work
  around it with Automations :facepalm:
- Cloud Agent Builds caching - Adrien asked why startups were slow, turned out Builds weren't
  actually caching. ~3 minutes down to ~10 seconds.
- Cloud Agent repo routing help entry - Answered Les on how Cloud Agents pick a repo, and wrote
  it up in the Notion help doc so I only have to explain it once.
- AOS All Hands, Weekly Engineering Exchange, Engineering Projects Review - Attended, and picked
  up a good orchestration conversation with Mathieu out of Projects Review.
- ADSK onboarding - Mostly wrapped. A few stragglers left.

### Today
- ADSK onboarding - Killing off the last of it today.
- AB-104 - Giving Mikel a real review. Launchpad's getting Cloud Agents, which is great to see
  spreading.
- BUILD-402 - Manual cross-repo run to get a first read on the data.
- maintainx #48867 - Looks like this got reviewed, so I'll try to get it merged!

Happy Friday!

---

More blurbs, from older standups:

- "Finally got a dev Airtable set up."
- "I'm a just gonna copy Jacob's work."
- "It mostly makes sense, but it's also kinda black magic DBA territory."
- "Unless someone else wants to grab it, I'll try to get to pg_repack next week."
- "Some PRs I'm forgetting."

---

## What to copy

- **Fragments carry most of it.** "Merged." "Mostly wrapped. A few stragglers left." Dropping the
  subject is the default, not a shortcut.
- **Length tracks how much there is to say.** A mechanical merge gets one word. A judgment call
  gets a sentence. Nothing gets padded to match its neighbors.
- **Say what happened, not what the diff did.** "This should fix mx-authorization's startup
  failures!" over "Switched the NuGet source to CodeArtifact."
- **Numbers when there's a number.** "~3 minutes down to ~10 seconds." The tilde stays.
- **Name whoever prompted the work.** "Adrien asked why startups were slow", "Answered Les",
  "Giving Mikel a real review." Credit and context in the same two words.
- **The correction is the finding.** "Turned out we should just fix Renovate's settings rather
  than work around it with Automations :facepalm:" — what he learned, not what he shipped.
- **Incompleteness stated flatly.** "A few stragglers left." "Some PRs I'm forgetting." Never
  rounded up to done.
- **Exclamation points land on small wins**, not on the big items.
- **Slang does real descriptive work.** "kinda black magic DBA territory" is the most accurate
  available description, not decoration.
- **Volunteer the handoff.** "Unless someone else wants to grab it, I'll try to get to pg_repack
  next week."
- **Sign off with the day.** "Happy Friday!"
