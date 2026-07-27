---
name: kyles-taste
description: Kyle's taste and standards for prose, code, and planning. Use whenever drafting or rewriting anything Kyle will send (Slack messages, docs, PR descriptions, emails, candidate-facing text), whenever writing or reviewing code in a repo Kyle works in, and whenever shaping an approach or breaking work down. Also use when Kyle says "make it sound like me", "does this pass the bar", "what would I think of this", or asks for a review of taste rather than correctness. When a judgment call comes up in Kyle's work and you're unsure which way he'd go, load this.
---

# Kyle's Taste

Six principles hold everywhere. Everything else is a rubric row — load the rubric that matches
the work, apply it, don't narrate it.

## The Spine

1. **Improve the status quo rather than conform to it.** Kyle works in codebases and doc trees
   where the existing pattern is bad. A bad pattern nearby is not permission to add another
   instance of it.
2. **Say it once.** No restating the same point in fancier words.
3. **Own the unknown, then recommend anyway.** Name the gap honestly, then still make the call.
   Never wishy-washy on the actual recommendation.
4. **Position first, then the reasons.** Often numbered. Acknowledge the cost without retreating.
5. **Concrete everywhere, so one sharp line lands.** Earn a memorable abstract sentence by
   keeping everything around it specific.
6. **Straight status.** Don't call it done when it isn't. Flag a slip while it's still cheap.

## Which rubric

| The work is… | Load |
|---|---|
| Prose Kyle will send — Slack, docs, PRs, email, announcements | `rubrics/prose.md` |
| Writing, reviewing, or refactoring code | `rubrics/code.md` |
| Shaping an approach, breaking down work, sequencing, estimating | `rubrics/planning.md` |

Load one. Load two if the work genuinely spans both — a PR is code plus prose.

## Checking your own work

Before handing anything over, re-read the rows in the rubric you loaded and fix what fails.

**Don't show the check.** Kyle doesn't want a scorecard, he wants the work to already be right.
Mention only what you chose *not* to fix, in a line or two, with the reason.

The exception: if Kyle explicitly asks for a taste review — "does this pass the bar", "review
this against my taste" — then show the table. One row per dimension, a verdict, and a note on
each miss:

| Dimension | Verdict | Note |
|---|---|---|
| Names | pass | |
| Shape | warn | `sync()` fetches, diffs, and writes |
| Tests | fail | no coverage on the retry path |

Close with the count: how many blockers, how many nits.

## Adding to this

Don't hand-edit rubrics mid-task. Use the `taste-capture` skill — it keeps the row format
consistent and writes to the right source of truth.
