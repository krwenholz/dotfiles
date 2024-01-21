{ config, pkgs, ... }:

with import <nixpkgs> { };

{
  home.file = {
    ".config/nvim" = {
      recursive = true;
      source = ./nvim;
    };
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };
}
