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
    {
      legacyPackages = import nixpkgs {
        system = "aarch64-linux";
        config.allowUnfree = true;
      };
      homeConfigurations.kyle = home-manager.lib.homeManagerConfiguration {
        modules = [
          (import ./home/home.nix)
          ({lib,...}:
          {
            home.username = lib.mkForce "code";
            home.homeDirectory = lib.mkForce "/home/code";
          })
        ];
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
      };
      homeConfigurations.code = home-manager.lib.homeManagerConfiguration {
        modules = [
          (import ./home/home.nix)
          ({lib,...}:
          {
            home.username = lib.mkForce "code";
            home.homeDirectory = lib.mkForce "/home/code";
          })
        ];
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
      };

      inherit home-manager;
      inherit (home-manager) packages;
    };
}
