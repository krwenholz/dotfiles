# Shell workarounds

- Always use `/usr/bin/make` instead of bare `make`. The zsh `compinit` completion system creates autoload stubs that Claude Code's shell snapshots capture incorrectly, causing bare `make` to fail.

## Version Control

Use `jj` instead of `git` for all version control operations. Do not use git commands.

For new jj bookmarks (and git branches), use the format of krw/ISSUE_ID (if working on work stuff) or krw/feature-name (if working on personal projects). For example, `jj bookmark krw/1234` or `jj bookmark krw/add-new-thing`.

## Testing

Always run the full test suite (`make check` or equivalent) after making code changes before presenting work as complete.

## Tools & Auth

For GitHub CLI operations, verify authentication status before attempting API calls. Use `gh auth status` first. Let Kyle authenticate if that fails rather than trying curl directly. (He mostly works in private repositories.)

## Output Formatting

When formatting output for Slack, use strict Slack mrkdwn syntax (not standard markdown). Do not include extraneous content in final output.

# Bash tool preferences

- Avoid command substitutions (`$(...)` and backticks) in Bash commands where possible. Prefer writing values directly or using simpler alternatives that don't require subshell
execution.
