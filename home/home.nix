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
      lsd
      lsof
      moreutils
      mosh
      vim
      ngrok
      nix-index
      ntp
      oathToolkit
      openssh
      openssl
      peek
      pinentry-curses
      ripgrep
      tmux
      tree
      unzip
      wget
      zsh
      fx
      fd
      gron
      nodePackages.prettier
      starship
      ncurses
      nix-direnv
      wireguard-tools
      stylua
      wireshark
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
