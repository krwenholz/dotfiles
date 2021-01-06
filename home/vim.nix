{ config, pkgs, ... }:

with import <nixpkgs> {};

let
  vim-me = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "vim-me";
    version = "8287405";
    src = fetchFromGitHub {
      owner = "krwenholz";
      repo = pname;
      rev = "82874056da9276b03dcc7e01d945ef9fab595a4a";
      sha256 = "0rw7b8161m30dp1nnv2l5rnbg5wvpx1cz233fyq8p3wh7bxszaxd";
    };
    meta.homepage = "https://github.com/krwenholz/vim-me";
  }; in
{
  home-manager.users.kyle = { pkgs, ...}: {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraConfig = builtins.readFile includes/vim/vimrc;
      plugins = with pkgs.vimPlugins; [
        LanguageClient-neovim
        UltiSnips
        base16-vim
        delimitMate
        deoplete-nvim
        easymotion
        fugitive
        fzf-vim
        fzfWrapper
        neoformat
        neoterm
        nerdtree
        polyglot
        syntastic
        tcomment_vim
        vim-airline
        vim-airline-themes
        vim-css-color
        vim-endwise
        vim-markdown
        vim-me
        vim-snippets
        vim-terraform
        vim-test
        vim-trailing-whitespace

    # Not found in nix packages
    #  Plugin 'ambv/black'
    #  Plugin 'vim-scripts/scratch.vim'
    #  Plugin 'tpope/vim-git'
    #  Plugin 'natew/ftl-vim-syntax'
    #  Plugin 'evanleck/vim-svelte'
    # May not need
    #  Plugin 'majutsushi/tagbar'
      ];
    };
  };
}
