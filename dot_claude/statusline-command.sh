#!/usr/bin/env bash
# Claude Code status line — mirrors starship prompt config
# Format: cyan user@hostname:path (blue git-branch) | model context%

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Substitute $HOME with ~ for display
home="$HOME"
display_path="${cwd/#$home/~}"

# Truncate path to last 8 components (mirrors starship truncation_length = 8)
shortened=$(echo "$display_path" | awk -F/ '{
  n = split($0, parts, "/");
  if (n <= 8) { print $0 }
  else {
    out = "";
    for (i = n-7; i <= n; i++) out = out "/" parts[i];
    print "..." out
  }
}')

user=$(whoami)
host=$(hostname -s)

# Get git branch (skip optional locks to avoid contention)
branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null) || \
  branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)

# Build prompt: cyan user@host:path
printf '\033[36m%s@%s\033[0m:\033[35m%s\033[0m' "$user" "$host" "$shortened"

if [[ -n "$branch" ]]; then
  printf ' \033[34m(%s)\033[0m' "$branch"
fi

# Append model and context usage if available
if [[ -n "$model" && -n "$used" ]]; then
  printf ' | %s \033[33m%.0f%%\033[0m used' "$model" "$used"
elif [[ -n "$model" ]]; then
  printf ' | %s' "$model"
fi
