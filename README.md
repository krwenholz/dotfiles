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

Personal Claude Code skills live in this repo as a plugin marketplace (`.claude-plugin/marketplace.json` + `.claude-plugins/personal-skills/`), independent of the chezmoi-managed dotfiles above. Install them on any machine (work laptop included) with:

```
/plugin marketplace add krwenholz/dotfiles
/plugin install personal-skills@krw-dotfiles
```
