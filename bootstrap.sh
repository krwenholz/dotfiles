sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
export PATH=$PATH:$HOME/.local/bin
chezmoi init git@github.com:krwenholz/dotfiles
chezmoi apply
