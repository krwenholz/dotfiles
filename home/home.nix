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
  };

}


# TODO(kyle): get this back in there
/*
  system.environment.pathsToLink = [
    "/share/nix-direnv"
  ];
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  virtualisation.docker.enable = true;
  users.users.kyle.extraGroups = [ "docker" ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  programs.mosh.enable = true;
  services.eternal-terminal = {
    enable = true;
    port = 60009;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";
    
    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
      THINGS = "$HOME/dinge";
    };

    packages = with pkgs; [
      ack
      entr
      eternal-terminal
      fwupd
      gcc
      git
      gitAndTools.diff-so-fancy
      gnumake
      gnupg
      highlight
      htop
      jq
      lsd
      lsof
      moreutils
      neovim vim
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

  # restart services on change
  systemd.user.startServices = "sd-switch";
  */