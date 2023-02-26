{ config, pkgs, modulesPath, ... }:

{
  imports = [] ++ (
        if builtins.pathExists ./hardware-configuration.nix
        then [
          ./hardware-configuration.nix
        ]
        else []
    ) ++ (
        if builtins.pathExists ./is_ec2
        then [
          "${modulesPath}/virtualisation/amazon-image.nix"
        ]
        else []
    )  ++ (
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

  ec2.hvm = builtins.pathExists ./is_ec2;

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
  programs.mosh.enable = true;
  services.eternal-terminal = {
    enable = true;
    port = 60009;
  };
  programs.gnupg.agent.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Packages!
  environment.systemPackages = with pkgs; [
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
  ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 8000 ];
    allowedTCPPortRanges = [
      { from = 60000; to = 60100; }
    ];
    allowedUDPPortRanges = [
      { from = 60000; to = 60100; }
    ];
  };
  services.openssh.enable = true;
}
