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

  outputs = { self, nixpkgs, home-manager, utils }:
    let
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        modules = [ (import ./home/home.nix) ] ++ (args.modules or []);
        pkgs = pkgsForSystem (args.system or "x86_64-linux");
      }) // { inherit (args) extraSpecialArgs; };

    in utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ] (system: rec {
      legacyPackages = pkgsForSystem system;
    }) // {
      homeConfigurations.kyle = mkHomeConfiguration {
        extraSpecialArgs = {};
      };
      homeConfigurations.code = mkHomeConfiguration {
        modules = [ ({lib,...}:
        {
          home.username = lib.mkForce "code";
          home.homeDirectory = lib.mkForce "/home/code";
        })];
        extraSpecialArgs = {};
      };
    };
}
