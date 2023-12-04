{ config, pkgs, ... }:

with import <nixpkgs> {};

{
  home.file = {
      ".config/nvim" = {
        recursive = true;
        source = ./AstroNvim;
        target = ".config/nvim";
      };
      ".config/nvim/lua/user" = {
        recursive = true;
        source = ./nvim.my;
        target = ".config/nvim/lua/user";
      };
    };
    programs.neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
}
