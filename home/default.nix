{ config, pkgs, ... }:
# TODO(kyle): https://github.com/ducaale/xh
# nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
# nix-channel --update
{
  imports =
    [
      ./git.nix
      ./shell.nix
      ./vim.nix
    ] ++ (
        if builtins.pathExists ./corporate.nix
        then [ ./corporate.nix ]
        else []
      )
      ;

  environment.systemPackages = [ (import ./custom-packages.nix) ];

  home-manager.users.kyle = { pkgs, ...}: {
    programs.home-manager.enable = true;
    programs.direnv.enable = true;
    #programs.direnv.nix-direnv.enable = true;

    home.packages = with pkgs; [
      firefox
      go
      goimports
      gopls
      gron
      nodePackages.typescript-language-server
      starship
      ncurses
      black
    ];
  };

  services.xserver.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kyle";
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";
  services.xserver.xkbOptions = "ctrl:swapcaps";

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
