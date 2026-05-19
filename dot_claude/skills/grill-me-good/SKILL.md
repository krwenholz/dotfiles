---
name: grill-me-good
description: Use when designing features, making architectural decisions, or resolving naming ambiguity — especially when language in discussion may conflict with the established domain model or glossary.
---

# grill-me-good

Conduct a systematic interview that stress-tests a plan or design against the project's domain model. Work through decisions one at a time — fully answered before moving on. Explore the codebase rather than speculating when answers could be found there.

## Context Store

Context lives in `~/.claude/context/<repo-name>/` — **not** in the repo. Derive `<repo-name>` from the basename of the current working directory.

| Structure | Path |
|---|---|
| Single context | `~/.claude/context/<repo-name>/CONTEXT.md` |
| Multiple contexts | `~/.claude/context/<repo-name>/CONTEXT-MAP.md` + subdirs |
| ADRs | `~/.claude/context/<repo-name>/adr/` |

**Lazy creation:** never pre-create empty files. Create `CONTEXT.md` when the first term resolves; create an ADR only when a decision is hard to reverse, surprising, and the result of a genuine trade-off.

`CONTEXT.md` is a glossary only — no specs, scratch pads, or implementation details.

## Interview Approach

**Terminology first.** Before drilling into design, check whether the user's language matches the glossary. If not: _"Your docs define X as A, but you're using it to mean B — which is correct?"_

**Precision over vagueness.** Push loose terms toward canonical ones. "Customer" vs "User" — pick one, define it, list the rest under _Avoid_.

**Scenario-driven.** Test edge cases with concrete examples: _"What happens when a Customer does X before Y?"_

**Code-glossary alignment.** If the codebase contradicts the glossary, surface it. Don't let implementation drift go unquestioned.

## CONTEXT.md Format

```md
# {Context Name}

{One or two sentence description.}

## Language

**{Term}**:
{One or two sentence definition — what it IS, not what it does.}
_Avoid_: {alias}, {alias}
```

Rules:
- Pick the canonical word; list others as _Avoid_ aliases
- Flag ambiguous terms explicitly with a clear resolution
- Only include terms specific to this project — not general programming concepts
- Group under subheadings when natural clusters emerge; flat list is fine if everything belongs to one cohesive area
