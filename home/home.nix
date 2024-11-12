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
      fd
      fx
      gcc
      gitAndTools.diff-so-fancy
      gnumake
      gnupg
      gron
      highlight
      htop
      jq
      litecli
      lsd
      lsof
      moreutils
      mosh
      ncurses
      ngrok
      nix-direnv
      nix-index
      nodePackages.prettier
      ntp
      oathToolkit
      openssh
      openssl
      peek
      pinentry-curses
      ripgrep
      starship
      stylua
      tmux
      tree
      unzip
      vim
      wget
      wireguard-tools
      wireshark
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
