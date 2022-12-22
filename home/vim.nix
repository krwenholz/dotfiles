{ config, pkgs, ... }:

with import <nixpkgs> {};

{
  home-manager.users.kyle = { pkgs, ...}: {
    home.file = {
      ".config/nvim/lua/config.lua".text = builtins.readFile includes/vim/config.lua;
    };
    programs.neovim = {
      enable = true;
      extraConfig = "lua require('config')";
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        base16-vim
        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        cmp_luasnip
        nvim-treesitter
        delimitMate
        easymotion
        friendly-snippets
        fugitive
        fzf-vim
        fzfWrapper
        luasnip
        leap-nvim
        neoformat
        neoterm
        nerdtree
        nvim-cmp
        nvim-lspconfig
        polyglot
        syntastic
        tcomment_vim
        vim-airline
        vim-airline-themes
        vim-css-color
        vim-endwise
        vim-markdown
        vim-snippets
        vim-terraform
        vim-test
        vim-trailing-whitespace
      ];
    };
  };
}
