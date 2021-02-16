{ config, pkgs, ... }:
# TODO(kyle): https://github.com/ducaale/xh
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

  home-manager.users.kyle = { pkgs, ...}: {
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
      cowsay
      firefox
      go
      goimports
      gopls
      nodePackages.typescript-language-server
      starship
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
}
