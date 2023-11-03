{ inputs, system, pkgs, ... }:

with inputs;

let
  imports = [
    ../home/home.nix
  ];

  mkHome = { hidpi }: (
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [{ inherit imports; }];
    }
  );
in
{
    home = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [{ inherit imports; }];
    };
}