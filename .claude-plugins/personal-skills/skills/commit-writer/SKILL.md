---
name: commit-writer
description: Use when writing or rewriting a commit message — for `jj describe`, `git commit`, squashing, or amending. Applies the seven rules of a great commit message (cbea.ms/git-commit, tbaggery.com).
---

# Commit Writer

Write commit messages following the seven rules from Chris Beams' [How to Write a Git Commit Message](https://cbea.ms/git-commit/) and Tim Pope's [original 2008 note](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

## The Seven Rules

1. **Separate subject from body with a blank line.** The first line is the title used by `log --oneline`, `shortlog`, GitHub, etc. Tools like `rebase` get confused without the blank line.
2. **Limit the subject line to 50 characters.** Soft limit — 50 is the goal, 72 is the hard ceiling before GitHub truncates.
3. **Capitalize the subject line.** "Add retry handler" not "add retry handler".
4. **Do not end the subject line with a period.** Wastes one of your 50 characters.
5. **Use the imperative mood in the subject line.** Test: "If applied, this commit will ___" should read naturally. Matches what `git merge` and `git revert` generate themselves.
6. **Wrap the body at 72 characters.** Plays nicely with `git log` indentation and `git format-patch` email output.
7. **Use the body to explain *what* and *why*, not *how*.** The diff shows how. The message explains why this change exists, what problem it solves, and any non-obvious consequences.

## Imperative mood — quick check

| ✅ Imperative | ❌ Past tense | ❌ Present tense |
|---|---|---|
| Add retry handler | Added retry handler | Adds retry handler |
| Fix race in token refresh | Fixed race in token refresh | Fixes race in token refresh |
| Remove deprecated methods | Removed deprecated methods | Removes deprecated methods |

If "If applied, this commit will ___" doesn't complete naturally, the mood is wrong.

## When to skip the body

Most commits don't need one. Skip it when the subject is fully self-explanatory.

**Include a body when:**
- The *why* isn't obvious from the diff
- There's a non-obvious consequence, tradeoff, or side effect
- A future reader will want context that isn't in the code
- You're undoing or working around something — say what and why

## Example with body

```
Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters. The blank line separating the summary from the body is
critical; tools like rebase can get confused without it.

Explain the problem this commit solves. Focus on why you are making
this change as opposed to how — the code already shows how. Are there
side effects or unintuitive consequences? Here's the place.

- Bullets are fine, hyphen or asterisk preceded by a single space

Resolves: #123
```

## Subject-only examples (the common case)

```
Auto-start socat bridges via postStartCommand
Drop stale "30 checks" and DOCKER_HOST mentions from README
Restructure README for clearer first-time and daily flows
```

## Applying this via jj

Kyle uses `jj`, not `git`. The seven rules apply identically — the mechanics differ slightly:

- Subject only: `jj describe -m "Add retry handler"`
- With a body: pass `-m` multiple times; each becomes a paragraph separated by a blank line
  ```
  jj describe -m "Add retry handler" -m "Upstream API started flaking on 5xx around 10% of calls. Retry with exponential backoff up to 3 attempts."
  ```
- Or run `jj describe` with no `-m` to open an editor for full multi-paragraph bodies.

## Common mistakes

| Mistake | Fix |
|---|---|
| "Updated X" / "Fixed Y" | Use imperative: "Update X" / "Fix Y" |
| Subject ends with a period | Drop it |
| Subject > 50 chars when 40 would do | Cut filler words; the body can carry detail |
| Body paraphrases the diff ("changed foo to bar") | Explain *why* the change exists, not what changed |
| No blank line between subject and body | Always blank line; tools depend on it |
| Lowercase subject | Capitalize the first word |

## Red flags

- Subject starts with "Updated", "Fixed", "Added", "Refactored" → past tense, rewrite as imperative
- Subject ends with "." → trim it
- Subject + body run together on consecutive lines → insert blank line
- Body is a restatement of the diff → either remove it or rewrite to explain *why*
