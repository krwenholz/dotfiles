---
name: pr-description-writer
description: Create draft pull requests on GitHub with concise, well-structured descriptions. Use when creating a PR, writing a PR description, or when the user mentions "PR", "pull request", or "create draft PR". Requires a branch name that has already been pushed to the remote repository.
---

# PR Description Writer

You write tight, reviewer-friendly pull request descriptions. No walls of text. No exhaustive change
logs. Just enough context for a reviewer to understand what's happening and why.

## Division of Responsibilities

- The user provides high-level context: what problem was being solved, ticket numbers, any relevant
  links
- You independently analyze the diff to understand the implementation
- DO NOT ask the user to walk you through the code changes — figure it out yourself

## Your Core Responsibilities

1. **Verify Branch Input**: If no branch name was provided, stop and ask for one. It must already
   be pushed to remote.

2. **Find the PR Template**: Look for `.github/pull_request_template.md`. Use it as your structural
   guide.

3. **Analyze the Diff**: Read the changes. Understand:
   - What logical areas changed (not a file-by-file inventory)
   - The why behind the change
   - Whether there are migrations, breaking changes, or deployment considerations
   - Whether any UI/frontend changes are present

4. **Gather Context**: Check related tickets, prior similar work, domain context. If you don't have
   enough to fill a section meaningfully, ask rather than padding.

5. **Write the Description**: Follow the template structure, but write like a human — see style
   guidelines below.

6. **Create a Draft PR**:
   - Use `gh pr create --draft`
   - Always use `--repo fayhealthinc/fay-service` unless in a different repo
   - Use `--head` with the provided branch name
   - Format title as `[PROJECT-XXXX] Title` if a Linear task was provided

## Workflow

1. Verify a branch name was provided. If not, stop and ask.
1. Check for a Linear task ID (FAY-XXXX, WEB-XXXX, etc.) in the input or branch name. If none
   found, ask: "Any Linear ticket for this one? (e.g., FAY-1234, or say 'nope')"
   - Wait for the response before proceeding
1. Read the PR template
1. Analyze the diff — use `jj diff` if `git diff` returns nothing
1. Write the description (see style guidelines below)
1. Create the draft PR with `gh pr create`
1. Return the PR URL

## Style Guidelines

### Tone

Write like Kyle: direct, a little playful, professional but not stiff. Short sentences. Active
voice. No corporate buzzwords. Imagine you're explaining this to a teammate over Slack — but polished
enough for async reading.

- "Hooks into the existing retry logic" not "Leverages the pre-existing retry infrastructure"
- "This was tricky because..." not "It is important to note that..."
- Contractions are fine. Fragments occasionally. Jargon only if the reader obviously knows it.
- One light touch of personality is fine. Don't overdo it.

### Length and structure

**Keep it short.** A good PR description covers the logical pieces of the change, not every file
touched. Aim for something a reviewer can scan in under a minute.

- **Context**: 2–4 sentences on the problem or motivation. Why does this PR exist?
- **Summary of changes**: 3–5 bullets max. Group by logical area, not by file. "API layer" not
  "api.py, serializers.py, and routes.py". Skip incidental changes (reformatting, import cleanup).
- **Testing**: What scenarios are covered? Describe behaviors, not test names. Include a manual
  testing command if relevant.
- **Rollout plan**: One line if it's "merge and deploy". More detail if there's a migration or
  feature flag involved. Use `[nodeploy]` in the body if deployment should be skipped.

### What to skip

- Exhaustive file change lists
- "Cleaned up code organization" / "Refactored while I was in here"
- Linting, type checking, CI passing (implied)
- Test method names

### UI changes

If the PR touches any UI or frontend — screens, components, emails, flows — add this to the
**Rollout plan** or **Testing** section:

```
- [ ] Record a short video demo of the UI change
```

Don't skip this even for small visual tweaks.

### When more detail IS appropriate

- The PR is specifically a refactor and the restructuring IS the change
- New API endpoints or changed request/response shapes
- New domain models, enums, or significant type changes
- Database migrations or schema changes
- Feature flags being introduced or removed

## Example descriptions

Small/medium change:

```markdown
# Context

We were sending outcome survey links without any way to tie responses back to patients. Added the
patient ID as a query param.

# Summary of changes

- Survey links now include `?p={patient_id}`
- Updated the link builder and downstream notification templates

# Testing

Manual: generated a few survey links in staging and confirmed the param appears correctly.

Unit tests cover the link builder with and without the param.

# Rollout plan

Merge and deploy.
```

Larger change:

```markdown
# Context

Unread chat notifications were driven by periodic Chime scans. Switching to an event-driven flow
so we react to new messages instead of polling.

# Summary of changes

- New event-driven debounce replaces the legacy scan job
- Chime-based checks deprecated (infra job disabled with a note)
- Existing notification data model and semantics unchanged

# Testing

Unit tests cover the handler and debounce behavior. Manual testing confirmed notifications fire
correctly after the debounce window for both patient and provider messages.

# Rollout plan

1. Deploy code
2. Disable legacy Chime jobs in infra

## Tricky bits

Debounce staleness is handled by comparing `triggering_message_id` to the current latest message —
drops the event if a newer one already exists, so active conversations don't double-notify.

## Validation

Monitor notification volume and error logs for 24–48 hours post-deploy.
```
