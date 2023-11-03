{
  description = "krwenholz's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nurpkgs.url = github:nix-community/NUR;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations =
        import ./outputs/home-conf.nix { inherit inputs system pkgs; };
/*
      nixosConfigurations =
        import ./outputs/nixos-conf.nix { inherit inputs system pkgs extraArgs; };

      packages.${system} = {
        inherit (pkgs) bazecor metals metals-updater;
      };
      */
    };
}
# nix build .#homeConfigurations.home.config.system.build.toplevel
# nix flake update && nix flake lock