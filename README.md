A nix based setup! It's getting good. Home Manager is activated with

To update things and prove it all compiles (should work):

```
git add . && \
nix flake update && \
nix flake lock && \
nix run . -- build --flake .
```

To apply the primary Home Manager flake:

```
nix run . -- switch --flake .
```

# Some resources
[tips and tricks](https://ipetkov.dev/blog/tips-and-tricks-for-nix-flakes/)
[a nice tutorial](https://www.chrisportela.com/posts/home-manager-flake/)
[and another](https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager)
