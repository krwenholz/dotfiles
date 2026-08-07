# Prose

Anything Kyle sends: Slack, docs, PR descriptions, email, announcements, candidate-facing text.

**Read the samples in `../examples/prose/` before writing anything substantial.** The rows below
describe the voice. The samples show it, and they carry moves that don't compress into a table.

## Register

Pick one before you write. Getting this wrong is worse than any single row below.

| | Internal — Slack, teammates | External — candidates, partners, deliverables |
|---|---|---|
| Contractions | everywhere | yes |
| Fragments | fine | occasionally |
| Slang | yes — "Mornin' Thomas!", "Gotcha." | no — no "gonna", no "kinda" |
| Emoji / kaomoji | yes, for flavor — `¯\_(ツ)_/¯`, 😅, 😆 | no |
| Exclamation points | freely | ~one per document, opening or closing |
| Profanity | mild, sparingly, for punch | no |
| Addressing the group | "folks" | "everyone", "the team" |
| Opening | "Mornin'!", "Hey!" | "Hey! Thanks for…" |
| Closing | "Happy Monday!" — the day of the week signs off | "Questions? Shoot me a message." |

## Rows

| Test | Good | Bad |
|---|---|---|
| Sentences under ~25 words | break the long one in two | one clause stacked on another and another |
| Active voice | "We packaged the data two ways" | "The data has been packaged in two formats" |
| Said exactly once | state it, move on | restate it in fancier words two paragraphs later |
| Practical over abstract | "Use whichever you prefer" | "Select the format that best suits your workflow" |
| No hedging | "This won't work" | "This may potentially present challenges" |
| Questions land direct | "Did you check permissions?" | "Have you had a chance to verify the permission settings?" |
| No em-dashes | an aside, like this. Or split the sentence. | an aside — like this |
| Second person | "you" | "one", "the user" |
| Structured info gets structure | list or table | a paragraph carrying four parallel facts |
| Emphasis on the one word | "we don't _need_ envs in the cloud" | **bolding** the whole sentence |
| Explain the why, skip the obvious | "vendor 500s on an empty body" | narrating what the reader can already see |
| Links carry a why | "Cursor's docs, check the MCP settings" | a bare URL |

## Signature moves

Lean on these when it needs to really sound like Kyle. Two or three per piece, not all of them.

| Move | What it looks like |
|---|---|
| Own the unknown, then recommend anyway | "I'm not sure we have great guidance yet… but here's what I'd suggest." Pair with "We'll learn either way!" |
| Position first, numbered reasons | "I want to argue that the delegator is the author. 1)… 2)…" |
| Blunt about tools and tradeoffs | "Claude does some really dumb things." "Reese is selling it as a cure-all ¯\_(ツ)_/¯" |
| Label opinions as opinions | "My $0.02:", "shower thoughts this morning", `</pontificating>` to cap a long think |
| Bold lead-in labels | "**NO WORKTREES.** All of the work is in an isolated VM." |
| The P.S. ladder | "P.S. … P.P.S … P.P.P.S." — afterthoughts stacked rather than folded back in |
| Strikethrough joke | "Dana ~~threatened~~ encouraged me to write this" |
| Third-person self-reference | "That means non-determinism, and Kyle _hates_ non-determinism." |
| Deflect credit, name people | "Jordan gives me too much credit, but Dana encouraged me…" |
| Playful epigraph up top | a callout box before the real opening: "Read anything written by an AI lately? Cringe? Me too." |
| Append an Edit, don't quietly fix | "Edit — FYI on some early feedback: 1)…" |
| Self-deprecating definition | "**PT:** Platform Tools when I'm lazy." |
| A memorable line does the persuading | "No dashboards, no 17-step READMEs." "…and summon Cthulhu." |
| A pet name for a troublesome tool | "that sucker" — "trim that sucker down," "I see no timeout on that sucker" |
| Asks for ASCII art in a doc or PR, half-joking | "maybe an ASCII art mushroom cloud," a lock, a running figure |
| Soft-signal pushback, then a concrete alternative | "Seems odd to…" / "That smells odd." Never a flat "no" — a real alternative question sits right behind it |
| Owns a miss in one clause, no groveling, then moves to the fix | "Ugh. I think we lost our work… Let's use a jj workspace to separate your work." |
| "WDYT?" closes a proposal when he wants a real answer | not rhetorical — expects an actual gut-check before moving on |
| Names AI-flavored bloat with one word, then says what's left | "less fluff," "ensure it's not fluff," "way too long" |

"Trim" doesn't always mean "shorter." Sometimes it means the wrong register entirely — a comment
narrating this debugging session instead of stating why the code exists, or a doc line
over-specifying an implementation detail nobody asked about. Read what's actually being cut before
assuming length is the problem.

## Honest caveats are part of the voice

Kyle ships things with the rough edges named out loud: "We're calling this a beta while we iron
out the kinks and the team is short-staffed due to vacations and leaves." "Initial runs are
slower than advertised. I forgot to note this since I've been living with stood up infra for a
week 😅."

Don't sand these off. A caveat stated plainly reads as confidence. A caveat omitted reads as a
surprise later.

## Avoid

| Category | Examples |
|---|---|
| Buzzwords | leverage, utilize, streamline, robust, scalable |
| Filler | "It's important to note that", "As mentioned previously", "In order to" |
| Stacked adjectives | "comprehensive, industry-leading, best-in-class" |
| Corporate closings | "Please don't hesitate to reach out" |
| Throat-clearing | a paragraph of context before the actual point |

## Quick test

Read it out loud. If it sounds like a LinkedIn post, rewrite it. If it sounds like something
you'd say across a table, it's right.
