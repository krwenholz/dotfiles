---
name: taste-capture
description: Record a new opinion into Kyle's taste rubrics (kyles-taste). Use when Kyle says "add that to my taste", "remember that I like/hate X", "that's a rule now", "capture that", or corrects the same thing more than once. Also use when Kyle rejects a suggestion on grounds of taste rather than correctness — that rejection is a rule worth writing down. Offer to capture proactively when you notice Kyle correcting the same class of thing twice in a session.
---

# Taste Capture

Write a new opinion into `kyles-taste` without breaking the format or losing what's there.

## 1. Find the real source of truth

The `kyles-taste` skill ships from Kyle's dotfiles repo through a plugin marketplace. The
installed copy under `~/.claude` is a **cache** — edits there are destroyed on the next plugin
update. Always edit the dotfiles source.

```
chezmoi source-path
```

Rubrics live at `<source-path>/.claude-plugins/personal-skills/skills/kyles-taste/rubrics/`.

If `chezmoi` isn't available, look for a `dotfiles` checkout containing
`.claude-plugin/marketplace.json`. If you can only find the plugin cache, stop and tell Kyle —
don't write a change that's going to evaporate.

## 2. Pick the rubric

| The opinion is about… | File |
|---|---|
| how something should read | `rubrics/prose.md` |
| how code should be written or reviewed | `rubrics/code.md` |
| how work should be shaped or sequenced | `rubrics/planning.md` |

If it's true across all three, it belongs in the Spine in `SKILL.md` — but the Spine is six
items and should stay that way. Adding a seventh means arguing that one of the six is really a
rubric row. Make that argument to Kyle before doing it.

If it fits nowhere, ask whether it's a new rubric. Don't create one unprompted.

## 3. Write the row

Match the table already in the file. Most rubrics use:

```
| Dimension | Test | Good | Bad |
```

Rules for a good row:

- **One idea.** If the test doesn't fit in a cell, it's two rows.
- **The test is a question you can answer yes or no.** "Could a new teammate guess it without
  reading the body?" not "Names should be clear."
- **Both examples are concrete.** Real identifiers, real phrasings. Not "a good name" / "a bad
  name."
- **No ALL-CAPS MUST/NEVER.** Rules in caps get followed literally and miss the cases they
  weren't written for. State the rule; the why lives in the prose section below the table.

## 4. Anonymize it

This skill ships publicly through a plugin marketplace, and it should outlive any one job. What
you capture almost always comes from real work, so scrub it on the way in.

Replace, keeping the shape and the register:

| Kind | Replace with |
|---|---|
| Coworker, candidate, or manager names | placeholder first names — Ana, Ben, Cleo |
| Repo, service, and product names | what the thing is — `api-gateway`, `monorepo`, "the help doc" |
| Ticket IDs and project keys | `PROJ-402`, `TEAM-104` |
| Company, employer, and internal meeting names | the generic function — "All Hands", "new-hire onboarding" |
| Vendor and tool names | the category, unless the tool *is* the point — "the dependency bot" |
| Customer names, URLs, account IDs, ARNs | drop them |

Don't sand off the voice while you're at it. Slang, profanity, kaomoji, and self-deprecation all
stay — they're the reason the sample exists. It's only the identifying nouns that go.

Keep enough specificity that the row still teaches. "Ana asked why startups were slow" carries
the lesson; "a teammate asked a question" doesn't. And say so at the top of a new sample file, so
the next reader doesn't try to look these people up.

## 5. Add and reconcile — don't delete

The default is additive. When the new opinion touches an existing row:

- **Compatible** → sharpen the existing row in place. Better test, better example.
- **Narrower** → amend the existing row with the exception rather than adding a near-duplicate.
- **Contradictory** → this is the one case to stop. Show Kyle both the old row and the new
  opinion, and ask which wins. Never resolve a contradiction on your own.

**Never delete a row unless Kyle says to delete it.** A rubric that quietly loses opinions is
worse than one that's slightly too long.

Rewriting the surrounding prose to accommodate a new row is fine and expected — that's
reconciling. Rewriting it to *remove* an opinion is not.

## 6. Land it

Show Kyle the diff. Then commit to the dotfiles repo with a message naming the opinion, not the
file:

```
Add non-determinism row to the code rubric
```

Push. Remind him the change reaches his other machines when the plugin updates — the local cache
is still stale until then.
