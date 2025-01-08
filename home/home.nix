{ config, lib, pkgs, specialArgs, ... }:

let
in
{
  programs.home-manager.enable = true;

  imports = [
    ./shell
    ./git
    ./vim
    ./activations
    #./custom-packages.nix
  ];
  #  ++ (
  #      if builtins.pathExists ./corporate.nix
  #      then [ ./corporate.nix ]
  #      else []
  #  );

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "kyle";
    homeDirectory = "/home/kyle";
    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
      THINGS = "$HOME/dinge";
    };

    packages = with pkgs; [
      ack
      entr
      gcc
      gitAndTools.diff-so-fancy
      gnumake
      gnupg
      highlight
      htop
      jq
      jujutsu
      lsd
      moreutils
      ncurses
      ngrok
      nix-direnv
      nix-index
      nodePackages.prettier
      ntp
      openssh
      openssl
      pinentry-curses
      ripgrep
      starship
      stylua
      tmux
      tree
      unzip
      wget
      wireguard-tools
      zsh
    ];
  };

  systemd.user.startServices = "sd-switch";

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
