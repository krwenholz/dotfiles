{
  description = "kyle's configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./home/default.nix
      ];
    };
  };
}