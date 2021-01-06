{ config, pkgs, ... }:
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
      xclip
    ];
  };
}
