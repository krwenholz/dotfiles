--[[
  borrowed, liberally, from https://github.com/nvim-lua/kickstart.nvim
--]--[[ ] ]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.ttimeoutlen = 3000 -- Wait for input after leader key

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- {
  --   "RRethy/nvim-base16",
  --   priority = 1000,
  --   config = function()
  --     --vim.cmd.colorscheme("base16-default-dark")
  --     vim.cmd.colorscheme("base16-solarized-light")
  --   end,
  -- },
  {
    "maxmx03/solarized.nvim",
    priority = 1000,
    config = function()
      require("solarized").setup({
        transparent = {
          enabled = false,
        },
        variant = "spring", -- "spring" | "summer" | "autumn" | "winter" (default)
      })
      vim.cmd.colorscheme("solarized")
      vim.o.background = "light"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Install parsers for these languages
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "python",
          "javascript",
          "typescript",
          "json",
          "yaml",
          "markdown",
          "bash",
          "rust",
          "go",
          "terraform",
          "toml",
          "xml",
          "html",
          "jq",
          "json",
          "mermaid",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,
          -- Disable for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },

        indent = {
          enable = true,
        },
      })
    end,
  },

  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_c = {
          {
            "buffers",
            show_filename_only = true,
            hide_filename_extension = false,
            show_modified_status = true,
            mode = 2, -- Shows buffer name + buffer index
            max_length = vim.o.columns * 2 / 3, -- Takes up to 2/3 of statusline width
            symbols = {
              modified = " [+]",
              alternate_file = "",
              directory = "",
            },
          },
        },
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

  -- Let's close brackets and stuff!
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Use Treesitter for better context
      ts_config = {
        lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
        javascript = { "template_string" },
      },
    },
  },

  -- LSP Setup (auto-install language servers)
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "gopls", -- Go
        "rust_analyzer", -- Rust
        "ts_ls", -- TypeScript/JavaScript
        "pyright", -- Python
        -- Add more language servers as needed
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Auto-detect poetry venv
      local function get_python_path()
        local cwd = vim.fn.getcwd()
        local venv_path = cwd .. "/.venv/bin/python"
        if vim.fn.filereadable(venv_path) == 1 then
          return venv_path
        end
        return "python3" -- fallback
      end

      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", ".git" },
        settings = {
          python = {
            pythonPath = get_python_path(),
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      }

      -- Other LSPs...
    end,
  },

  -- Telescope for file finding and search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "^.git/" },
          cache_picker = {
            num_pickers = 10,
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            additional_args = function()
              return { "--hidden" }
            end,
          },
        },
      })
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")

      -- Smart find_files that preserves query but refreshes results
      local function smart_find_files()
        builtin.find_files({
          default_text = last_find_files_query,
          attach_mappings = function(_, map)
            -- Save query on close
            map("i", "<CR>", function(prompt_bufnr)
              local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
              last_find_files_query = picker:_get_prompt()
              require("telescope.actions").select_default(prompt_bufnr)
            end)
            return true
          end,
        })
      end

      -- Smart live_grep that preserves query but refreshes results
      local function smart_live_grep()
        builtin.live_grep({
          default_text = last_live_grep_query,
          attach_mappings = function(_, map)
            -- Save query on close
            map("i", "<CR>", function(prompt_bufnr)
              local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
              last_live_grep_query = picker:_get_prompt()
              require("telescope.actions").select_default(prompt_bufnr)
            end)
            return true
          end,
        })
      end
      vim.keymap.set("n", "<leader>ff", smart_find_files, { desc = "Find files (smart resume)" })
      vim.keymap.set("n", "<leader>fg", smart_live_grep, { desc = "Live grep (smart resume)" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })

      -- Manual resume for any picker
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last picker" })
      vim.keymap.set("n", "<leader>fp", builtin.pickers, { desc = "Previous pickers" })
    end,
  },

  { "nvim-tree/nvim-web-devicons", opts = { override = {}, default = true } },

  -- Breadcrumbs showing class/function context
  -- You'll need "Symbols Nerd Font" installed for this to look decent
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-tree/nvim-web-devicons",
      build = "make",
    },
  },

  -- Autocomplete from LSP
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      sources = {
        default = { "lsp", "path", "buffer", "snippets" },
      },
    },
  },

  -- AI Completion (supports Claude, OpenAI, etc.)
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("minuet").setup({
  --       provider = "claude",  -- or "openai", "gemini", etc.
  --       -- Add your API key via environment variable or here
  --       -- For Claude: export ANTHROPIC_API_KEY=your_key
  --     })
  --   end,
  -- },

  -- Optional: GitHub Copilot (if you have access)
  -- Uncomment if you want to use Copilot instead
  {
    "github/copilot.vim",
  },

  -- And some nice autoformatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_poetry" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        terraform = { "tflint" },
      },
      formatters = {
        ruff_poetry = {
          command = "poetry",
          args = { "run", "ruff", "format", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true, -- Use LSP formatting if no formatter available
      },
    },
  },
  -- And awesome search
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set search settings
vim.o.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Some nice tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

-- File change detection
-- Enable autoread to reload files changed outside vim
vim.o.autoread = true

-- Trigger checktime more frequently
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
  pattern = "*",
})

-- Show a notification when file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
  pattern = "*",
})

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Jump back and forward (like VS Code's back/forward buttons)
vim.keymap.set("n", "<C-(>", "<C-o>", { desc = "Jump back" })
vim.keymap.set("n", "<C-)>", "<C-i>", { desc = "Jump forward" })

-- [[ LSP Keymaps ]]
-- these work when LSP is attached
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    local builtin = require("telescope.builtin")

    -- Use Telescope for definitions and references (auto-closes on selection)
    vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
    vim.keymap.set("n", "gr", builtin.lsp_references, opts)
    vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)

    -- built-in LSP stuff
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- Diagnostics
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>dd", builtin.diagnostics, opts)
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
