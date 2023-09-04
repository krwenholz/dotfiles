{ config, pkgs, ... }:

with import <nixpkgs> {};

{
  home-manager.users.kyle = { pkgs, ...}: {
    home.file = {
      ".config/nvim" = {
        recursive = true;
        source = ./includes/AstroNvim;
        target = ".config/nvim";
      };
      ".config/nvim/lua/user" = {
        recursive = true;
        source = ./includes/nvim.my;
        target = ".config/nvim/lua/user";
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
