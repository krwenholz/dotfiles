{
  description = "krwenholz's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, utils, ... }:
  let
    mkHomeConfig = usr: system: home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      modules = [
        (import ./home/home.nix)
        ({lib,...}:
        {
          home.username = lib.mkForce (usr);
          home.homeDirectory = lib.mkForce "/home/${usr}";
        })
      ];
    };
  in {
    homeConfigurations."kyle@x86_64" = mkHomeConfig "kyle" "x86_64-linux";
    homeConfigurations."kyle@aarch64" = mkHomeConfig "kyle" "aarch64-linux";
    homeConfigurations."code@x86_64" = mkHomeConfig "code" "x86_64-linux";
    homeConfigurations."code@aarch64" = mkHomeConfig "code" "aarch64-linux";
    homeConfigurations."code" = mkHomeConfig "code" "aarch64-linux";

    inherit home-manager;
    inherit (home-manager) packages;
  };
}
