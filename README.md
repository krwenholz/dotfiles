A nix based setup! It's getting good. Home Manager is activated with

To update things and prove it all compiles (should work):

```
git add . && \
nix flake update && \
nix flake lock && \
nix build .#homeConfigurations.kyle.home.activationPackage
```

To apply the primary Home Manager flake:

```
nix run home-manager/release-23.11 -- switch --flake .#homeConfigurations.kyle
```

# nix build .#homeConfigurations.home.activationPackage
# 

# Some resources
[tips and tricks](https://ipetkov.dev/blog/tips-and-tricks-for-nix-flakes/)
