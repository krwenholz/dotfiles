{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware-builder.nix
      ./vagrant.nix
    ] ++ (
        if builtins.pathExists /home/kyle/default.nix
        then [
          <home-manager/nixos>
          /home/kyle
        ]
        else []
      )
    ;

  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [ "wheel" "users" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    home = "/home/kyle";
  };

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Packages!
  environment.systemPackages = with pkgs; [
    ack
    fwupd
    gcc
    git
    gitAndTools.diff-so-fancy
    gnumake
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
    peek
    rclone
    ripgrep
    tldr
    tmux
    tree
    unzip
    wget
    zsh
  ];
}
