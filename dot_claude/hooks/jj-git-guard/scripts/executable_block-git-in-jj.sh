#!/bin/bash
# block-git-in-jj.sh - Block git commands in jj (Jujutsu) repositories

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd')
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Check if we're in a jj repository by walking up from cwd
check_jj_repo() {
  local dir="$1"
  while [ "$dir" != "/" ]; do
    if [ -d "$dir/.jj" ]; then
      return 0
    fi
    dir=$(dirname "$dir")
  done
  return 1
}

if ! check_jj_repo "$CWD"; then
  exit 0
fi

# We're in a jj repo - block commands that start with git
if echo "$COMMAND" | grep -qE '^\s*git(\s|$)'; then
  jq -n \
    --arg reason "Blocked: git commands are not allowed in Jujutsu (jj) repositories. Use jj commands instead." \
    '{
      "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "deny",
        "permissionDecisionReason": $reason
      }
    }'
  exit 0
fi

exit 0
