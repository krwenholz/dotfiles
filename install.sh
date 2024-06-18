# home-manager switch --flake "github:krwenholz/dotfiles#$(whoami)@$(uname -m)"
nix run home-manager/release-24.05 -- switch --flake "github:krwenholz/dotfiles#$(whoami)@$(uname -m)"
