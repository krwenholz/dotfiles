{ pkgs, lib, username, ... }:

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
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "unstable";

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
      pinentry
      pinentry-curses
      rclone
      ripgrep
      guardian-agent
      tmux
      tree
      unzip
      wget
      zsh
      docker-compose
      fx
      fd
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
      wireshark
    ];
  };

  systemd.user.startServices = "sd-switch";

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSshSupport = true;
  };
}
