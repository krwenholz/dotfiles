# home-manager switch --flake "github:krwenholz/dotfiles.#code@$(uname -m)-linux"
nix run home-manager/release-24.05 -- switch --flake "github:krwenholz/dotfiles.#code@$(uname -m)-linux"
