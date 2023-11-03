{ system, nixpkgs, nurpkgs, home-manager, ... }:

let
  username = "kyle";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.xdg.configHome = configHome;
    overlays = [ nurpkgs.overlay ];
  };

  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };
in
{
  home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs;

    modules = import ./home.nix {
      inherit nur pkgs;
      inherit (pkgs) config lib stdenv;
    };
  };
}