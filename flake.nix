{
  description = "kyle's configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nurpkgs = {
      url = github:nix-community/NUR;
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nurpkgs, home-manager, ... }: {
    homeConfiguration = import ./home/home-conf.nix {
     inherit nixpkgs nurpkgs home-manager;
     system = "x86_64-linux";
    };
  };
}
# nix build .#homeConfiguration.main.config
# nix flake update && nix flake lock