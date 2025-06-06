A nix based setup! It's getting good. Home Manager is activated with

To update things and prove it all compiles (should work):

```
git add . && \
nix flake update && \
nix flake lock && \
nix run ".#home-manager" -- build --flake ".#code@aarch64"
```

To apply the primary Home Manager flake:

```
nix run ".#home-manager" -- switch --flake ".#code@aarch64"
```

or

```
nix run home-manager/release-24.05 -- switch --flake "github:krwenholz/dotfiles#$(whoami)@$(uname -m)"
```

# Some resources

[tips and tricks](https://ipetkov.dev/blog/tips-and-tricks-for-nix-flakes/)
[a nice tutorial](https://www.chrisportela.com/posts/home-manager-flake/)
[and another](https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager)

# Somewhat interesting problems solved

- I have multiple flakes for different user names. These just nicely match the current user and can be applied simply.
- Because I'm using GitHub Codespaces as my primary environment, I do some startup script work. Some of this is in the extraEnv part of my shell to manage secrets.
