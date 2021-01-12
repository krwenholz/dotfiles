{ config, pkgs, ...}:

{
  imports = (
    if builtins.pathExists ./Source/ngrok
    then [
      ./Source/ngrok/devenv/nixos/module.nix
    ]
    else []
  );

  services.ngrok-devenv.enable = true;
  services.bind = { enable = true; forwarders = [ "1.1.1.1" ]; };

  home-manager.users.kyle = { pkgs, ...}: {
    programs.git = {
      extraConfig = {
        protocol.keybale.allow = "always";
      };
    };
  };
}
