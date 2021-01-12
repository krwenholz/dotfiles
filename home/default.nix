{ config, pkgs, ... }:
# nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
# nix-channel --update
{
  imports =
    [
      ./git.nix
      ./rclone.nix
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
      keybase keybase-gui kbfs
      cowsay
      go gopls
    ];
  };
}
