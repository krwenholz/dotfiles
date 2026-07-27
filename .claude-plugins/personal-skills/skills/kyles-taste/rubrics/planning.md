# Planning

Shaping an approach, breaking work down, sequencing, estimating.

## Rows

| Dimension | Test | Good | Bad |
|---|---|---|---|
| First step | Is the first step small and reversible? | turn the flag on for one team | big-bang cutover |
| Unknowns | Are they named, or buried in an assumption? | "we don't know how X behaves under load — 2h spike" | a plan that quietly assumes it works |
| Sequence | Ordered by risk, or by what's easy? | the scary part happens first | the scary part is saved for last |
| Done | Is "done" a thing you can observe? | "tests green and the job runs clean in staging for 24h" | "done when it's working" |
| Escape hatch | Can you turn it off without a deploy? | flag, beta label, one team at a time | it's live for everyone or nobody |
| Ownership | Does each piece have a name on it? | "Kyle: the IAM role. Sam: the seeds." | passive voice with no owner |
| Isolation | One unit of work, one workspace? | `jj workspace add ../repo-krw-1234` | three changes tangled in one tree |
| Honesty | Does the plan admit its constraints? | "beta while the team's short-staffed" | silent optimism about the timeline |

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
