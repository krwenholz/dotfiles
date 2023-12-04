{ inputs, system, pkgs, ... }:

with inputs;

{
    home = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [(import ../home/home.nix)];
    };
}