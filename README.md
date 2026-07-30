Simple. Get started with the below.

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
export PATH=$PATH:$HOME/.local/bin
chezmoi init git@github.com:krwenholz/dotfiles
chezmoi apply
```

or

```
curl -fsSL https://github.com.com/krwenholz/bootstrap.sh | sh
```

## Claude Code skills

Personal Claude Code skills live in this repo as a plugin marketplace (`.claude-plugin/marketplace.json` + `.claude-plugins/personal-skills/`), independent of the chezmoi-managed dotfiles above.

### Install

On a new machine (work laptop included):

```
/plugin marketplace add krwenholz/dotfiles
/plugin install personal-skills@krw-dotfiles
```

Both work as `claude plugin ...` from the shell too, if you're scripting the setup.

### Update

After pushing a change to the skills, pull it down on each machine:

```
/plugin marketplace update krw-dotfiles
/reload-plugins
```

### Shipping a change

`marketplace update` refreshes the catalog, but the plugin itself only updates when its
**version changes**. Bump both — they duplicate the field:

- `.claude-plugins/personal-skills/.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json` (the `personal-skills` entry)

Skip the bump and the merged change never reaches the other machines, silently.

(Dropping `version` from `plugin.json` entirely makes Claude Code use the git SHA instead, so
every commit counts as a new version and there's nothing to remember. Worth considering.)

### What's in it

| Skill | For |
|---|---|
| `kyles-taste` | Standards for prose, code, and planning. Rubrics loaded on demand. |
| `taste-capture` | Records a new opinion into the `kyles-taste` rubrics. |
| `commit-writer` | Commit messages, per the seven rules. |
| `pr-description-writer` | Draft PRs with short, reviewer-friendly descriptions. |
| `grill-me-good` | Stress-tests a design against the project's domain model. |
| `tuicr` | Launches the `tuicr` review TUI in a tmux split. |

Edits belong in this repo, not in the installed copy under `~/.claude` — that's a cache, and a
plugin update overwrites it.
