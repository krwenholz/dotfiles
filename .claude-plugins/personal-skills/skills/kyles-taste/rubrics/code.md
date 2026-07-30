# Code

The spirit of Clean Code, not the taxonomy. No function-length limits, no argument-count rules,
no class-per-responsibility ceremony. Seven things that actually matter.

## Rows

| Dimension | Test | Good | Bad |
|---|---|---|---|
| Names | Could a new teammate guess it without reading the body? | `pendingRetries` | `data2`, `handleStuff()` |
| Shape | Does the name describe everything the thing does? | `settleInvoice()` settles | `sync()` fetches, diffs, and writes |
| Tests | Does the path most likely to break have one? | retry exhaustion covered | happy path only |
| Comments | Does it explain *why*, not *what*? | "vendor 500s on an empty body" | `// loop over items` |
| Durability | Will the comment still make sense once this session or PR is forgotten? | states why the code exists | references a ticket number, or "per today's discussion," as the reason |
| Errors | Does a failure surface, or vanish? | wrapped and re-raised with context | `except: pass` |
| Duplication | Third occurrence? Extract. | one `parseCursor` | three near-copies drifting apart |
| Campsite | Is this file better than you found it? | fixed the name you tripped on | matched the bad name for consistency |

## Improve, don't conform

Kyle works in codebases where the status quo is bad. The default instinct — and most house style
guides, and most coding agents, including this one — says match the surrounding code. Here,
don't. A bad pattern nearby is not a license to add another instance of it.

The boundary: **leave the campsite cleaner, not rebuilt.** Fix what you touched and what you
tripped over on the way. A bugfix does not become a refactor. If the cleanup is bigger than the
change that prompted it, say so in a sentence and let Kyle make the call — don't silently do it,
and don't silently skip it.

## Non-determinism

Kyle hates non-determinism. If a change introduces a behavior that depends on timing, ordering,
network weather, or a model's judgment where a deterministic answer was available, that's a
finding — flag it even when everything else passes. When something could be scripted or
prompt-driven, prefer scripted: "is that prompt driven or scripted? Seems like something we can be
deterministic about."

## Before calling it done

Run the full suite (`make check` or the project's equivalent). "Done" means the tests ran and
passed, not that the code looks right. If they didn't run, say they didn't run.
