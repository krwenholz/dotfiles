{ pkgs, lib, ... }:

let
  username = "kyle";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
in
{
  programs.home-manager.enable = true;

  imports = [
    ./shell
    ./git
    ./vim
    #./custom-packages.nix
  ];
#  ++ (
#      if builtins.pathExists ./corporate.nix
#      then [ ./corporate.nix ]
#      else []
#  );

  nixpkgs.config.allowUnfree = true;

  home = {
  stateVersion = "23.11";
  username = "kyle";
  homeDirectory = "/home/kyle";  
  
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
      THINGS = "$HOME/dinge";
    };

    packages = with pkgs; [
      ack
      entr
      fwupd
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
      linuxKernel.packages.linux_5_15.perf
      pinentry
      pinentry-curses
      rclone
      ripgrep
      guardian-agent
      tldr
      tmux
      tree
      unzip
      wget
      zsh
      docker-compose
      firefox
      fx
      fd
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
      sumneko-lua-language-server
      stylua
      cargo
      rustc
      wireshark
    ];
  };

  systemd.user.startServices = "sd-switch";

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSshSupport = true;
  };
}