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

  outputs = { nixpkgs, nurpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      homeConfigurations = {
        kyle = (with { username = "kyle"; }; home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (import ./home/home.nix { inherit pkgs lib username; }) ];
        });
        code = (with { username = "code"; }; home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (import ./home/home.nix { inherit pkgs lib username; }) ];
        });
      };
    };
}
