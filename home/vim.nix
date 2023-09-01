{ config, pkgs, ... }:

with import <nixpkgs> {};

{
  home-manager.users.kyle = { pkgs, ...}: {
    home.file = {
      ".config/nvim" = {
        recursive = true;
        source = ./includes/nvim;
        target = ".config/nvim";
      };
    };
    programs.neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
  };
}
