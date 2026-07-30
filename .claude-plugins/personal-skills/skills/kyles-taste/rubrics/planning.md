# Planning

Shaping an approach, breaking work down, sequencing, estimating.

**Read the samples in `../examples/planning/` before shaping anything substantial.** The rows
below describe the moves. The samples show a real one running end to end.

## Rows

| Dimension | Test | Good | Bad |
|---|---|---|---|
| First step | Is the first step small and reversible? | turn the flag on for one team | big-bang cutover |
| Unknowns | Are they named, or buried in an assumption? | "we don't know how X behaves under load — 2h spike" | a plan that quietly assumes it works |
| Sequence | Ordered by risk, or by what's easy? | the scary part happens first | the scary part is saved for last |
| Done | Is "done" a thing you can observe? | "tests green and the job runs clean in staging for 24h" | "done when it's working" |
| Escape hatch | Can you turn it off without a deploy? | flag, beta label, one team at a time | it's live for everyone or nobody |
| Ownership | Does each piece have a name on it? | "Kyle: the IAM role. Jordan: the seeds." | passive voice with no owner |
| Isolation | One unit of work, one workspace? | `jj workspace add ../repo-krw-1234` | three changes tangled in one tree |
| Honesty | Does the plan admit its constraints? | "beta while the team's short-staffed" | silent optimism about the timeline |
| Triage | Does feedback get sorted into named buckets, or dumped as one list? | "fold into this PR / defer to follow-up / just do it / skip / spin out a new ticket" — one clause of reason each | an undifferentiated list with no disposition per item |

## Signature moves

Lean on these when reacting to or amending a plan, not just writing one from scratch.

| Move | What it looks like |
|---|---|
| Reframe the actual bar before judging against it | "The goal is not perfect security. What we're really shooting for is best effort." Then: "would you reconsider any of your points?" |
| Soft-signal pushback, then a concrete alternative | "Seems odd to…" / "That's a weird smell." Never a flat rejection — a specific question sits right behind it |
| Gate a big build behind a small spike | "Let's come up with a testing and validation plan… if it works, then we should consider the real build." |
| Names an unknown with a confidence number, not a shrug | "I'm 95% certain X applied, but…" / "not totally clear which repo, but sounds like you understand" |
| Exclusion is a decision, stated plainly | "Leave them off." "Skip it." "Drop it." — not silence, an answer |
| Compresses before presenting | two related PRs become "fold into one bullet," not two lines |
| "WDYT?" wants a real gut-check, not compliance | closes a proposal when he's genuinely unsure, not rhetorically |
| Two real paths get a doc and named reviewers, not a solo pick | "Let's dump these options into a lil' markdown doc… I want to share with [two people] to see if they have thoughts." |

## Shape of a good plan

Position first, then the reasons — same as the prose rubric. Lead with what you're going to do
and why, then the steps. Don't make the reader assemble the recommendation from a list of tasks.

State the recommendation even when the information is incomplete. "I'm not sure we have great
guidance here yet, but here's what I'd suggest" is a complete plan. "It depends" is not.

## When the plan turns out to be wrong

Renegotiate early and out loud. A slip flagged on day two is a scheduling conversation; the same
slip flagged on the deadline is a broken commitment.

Append the correction rather than quietly revising — the "Edit — FYI on some early feedback"
move from the prose rubric works here too. People who read the original plan need to see what
changed, not a document that has always said the new thing.

## Commits and history

Each concrete change gets its own commit with a short descriptive message. Prefer new commits
over amending. Offer to squash at natural milestones — an issue complete, a bug fully tracked
down, a logical unit ready for review — rather than doing it unasked.
