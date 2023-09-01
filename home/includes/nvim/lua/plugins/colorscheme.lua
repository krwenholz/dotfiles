return {
  -- add gruvbox
  { "RRethy/nvim-base16", commit = "6247ca9aa9f34644dfa290a6df3f6feefb73eb97" },

  -- Configure LazyVim to load base16
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "base16-default-dark",
    },
  }
}
