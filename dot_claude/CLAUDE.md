# Shell workarounds

- Always use `/usr/bin/make` instead of bare `make`. The zsh `compinit` completion system creates autoload stubs that Claude Code's shell snapshots capture incorrectly, causing bare `make` to fail.

## Version Control

Use `jj` instead of `git` for all version control operations. Do not use git commands.

For new jj bookmarks (and git branches), use the format of krw/ISSUE_ID (if working on work stuff) or krw/feature-name (if working on personal projects). For example, `jj bookmark krw/1234` or `jj bookmark krw/add-new-thing`.

### jj workspaces

We do a lot of parallel work, so prefer making changes in a dedicated jj workspace rather than the main working copy. Each unit of work gets its own workspace so concurrent changes stay isolated and don't collide.

- Create one per unit of work, named after the bookmark: `jj workspace add ../maintainx-krw-1234`. In the maintainx repo, run `mise trust` in the new workspace before working in it.
- Changes happen in that directory — `cd` into the workspace path to work there.
- `jj workspace list` shows all workspaces and their paths; `jj workspace forget <name>` removes one when the work is done.

Agents: I will forget how to get back to a workspace, so proactively remind me. When I ask where the work is or how to see it, tell me to `cd` into the workspace directory, then `jj log` to see that workspace's commits. Use `jj workspace list` to point me at the right path.

### jj commit workflow

Prefer creating new commits (with `jj new` or just letting the working copy advance) over amending/squashing into existing ones. Each concrete change should be its own commit with a short descriptive message. Move the bookmark forward to the new commit each time:

```
jj describe -m "Short description of change"
jj new
jj bookmark set krw/branch-name -r @-
jj git push --bookmark krw/branch-name
```

This preserves a readable history of individual changes. Offer to squash commits at natural milestones — e.g. when an issue is complete, a bug has been fully tracked down and fixed, or a logical unit of work is done and ready for review.

## Testing

Always run the full test suite (`make check` or equivalent) after making code changes before presenting work as complete.

## Tools & Auth

For GitHub CLI operations, verify authentication status before attempting API calls. Use `gh auth status` first. Let Kyle authenticate if that fails rather than trying curl directly. (He mostly works in private repositories.)

For `gh api` JSON, use `--jq` (gh has jq built in) instead of piping to `python3 -c`. For PR comments, prefer `gh pr comment` / `gh pr review` over building JSON payloads for `gh api`.

## Output Formatting

When formatting output for Slack, use strict Slack mrkdwn syntax (not standard markdown). Do not include extraneous content in final output.

## Taste

The `kyles-taste` skill holds Kyle's standards for prose, code, and planning. Load the matching
rubric before non-trivial work — writing anything Kyle will send, making a non-trivial code
change, or shaping an approach. Don't rely on it triggering on its own; the request usually
doesn't look like a taste question.

## Pull Request Descriptions

When writing PR descriptions:
- Keep them short — cover logical areas of the change, not individual files
- Tone: see the prose rubric in `kyles-taste`
- Skip incidental changes (import cleanup, reformatting, linting)
- For any UI/frontend changes, always include a to-do checkbox for a video demo

# Bash tool preferences

- Avoid command substitutions (`$(...)` and backticks) in Bash commands where possible. Prefer writing values directly or using simpler alternatives that don't require subshell
execution.

@RTK.md
