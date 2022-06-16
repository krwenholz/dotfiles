{ config, pkgs, ... }:
# TODO(kyle): https://github.com/ducaale/xh
# Upgrade:
# nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
# sudo nix-channel --add https://nixos.org/channels/nixos-22.05 nixos
# sudo nix-channel --add https://nixos.org/channels/nixos-22.05 nixpkgs
# nix-channel --update
# sudo nixos-rebuild switch --upgrade
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

  virtualisation.docker.enable = true;
  users.users.kyle.extraGroups = [ "docker" ];

  home-manager.users.kyle = { pkgs, ...}: {
    programs.home-manager.enable = true;
    programs.direnv.enable = true;

    home.packages = with pkgs; [
      firefox
      fx
      go
      gotools
      gopls
      gron
      nodePackages.typescript-language-server
      nodePackages.prettier
      starship
      ncurses
      black
      nix-direnv
      wireguard-tools
      pinentry-gtk2
    ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
