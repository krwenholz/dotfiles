{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ] ++ (
        if builtins.pathExists ./custom-auth.nix
        then [
          ./custom-auth.nix
        ]
        else []
    ) ++ (
        if builtins.pathExists /home/kyle/default.nix
        then [
          <home-manager/nixos>
          /home/kyle
        ]
        else []
    ) ++ (
        if builtins.pathExists ./hardware-builder.nix
        then [
          ./hardware-builder.nix
        ]
        else []
    ) ++ (
        if builtins.pathExists ./vagrant-hostname.nix
        then [
          ./vagrant-hostname.nix
        ]
        else []
    );

          # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";

  time.timeZone = "America/Los_Angeles";

  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [ "wheel" "users" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    home = "/home/kyle";
  };

  programs.zsh.enable = true;
  programs.gnupg.agent.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Packages!
  environment.systemPackages = with pkgs; [
    ack
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
    pinentry
    pinentry-curses
    rclone
    ripgrep
    tldr
    tmux
    tree
    unzip
    wget
    zsh
  ];

  services.openssh.enable = true;

  #networking.interfaces = {
  #  enp0s8.ipv4.addresses = [{
  #    address    = "10.110.0.2";
  #    prefixLength = 24;
  #  }];
  #  enp0s9.ipv4.addresses = [{
  #    address    = "10.110.1.2";
  #    prefixLength = 24;
  #  }];
  #  enp0s10.ipv4.addresses = [{
  #    address    = "10.110.2.2";
  #    prefixLength = 24;
  #  }];
  #};
}
