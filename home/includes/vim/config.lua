HOME = os.getenv("HOME")

------------------------------------------------------------------
-- Airline
------------------------------------------------------------------
vim.g.airline_theme = "base16"
vim.g.airline_powerline_fonts = 1
vim.cmd("let g:airline#extensions#tabline#enabled=1")
vim.cmd('let g:airline#extensions#tabline#left_sep = " "')
vim.cmd('let g:airline#extensions#tabline#left_alt_sep = "|"')
vim.cmd("let g:airline#extensions#whitespace#enabled = 1")

------------------------------------------------------------------
-- fzf
------------------------------------------------------------------
vim.g.fzf_layout = { down = "~40%" }

vim.g.fzf_colors = {
	fg = { "fg", "Normal" },
	bg = { "bg", "Normal" },
	hl = { "fg", "Comment" },
	info = { "fg", "PreProc" },
	border = { "fg", "Ignore" },
	prompt = { "fg", "Conditional" },
	pointer = { "fg", "Exception" },
	marker = { "fg", "Keyword" },
	spinner = { "fg", "Label" },
	header = { "fg", "Comment" },
}

vim.g.fzf_colors["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" }
vim.g.fzf_colors["bg+"] = { "bg", "CursorLine", "CursorColumn" }
vim.g.fzf_colors["hl+"] = { "fg", "Statement" }

vim.cmd([[
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
]])

-- Enable per-command history.
-- CTRL-N and CTRL-P will be automatically bound to next-history and
-- previous-history instead of down and up. If you don't like the change,
-- explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
vim.g.fzf_history_dir = HOME .. "/.local/share/fzf-history"

vim.api.nvim_set_keymap("n", "\\f", ":Find<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<c-f>", ":Files<CR>", { silent = true })

------------------------------------------------------------------
-- vim-test
------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "t<c-n>", ":TestNearest<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "t<c-f>", ":TestFile<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "t<c-s>", ":TestSuite<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "t<c-l>", ":TestLast<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "t<c-g>", ":TestVisit<CR>", { silent = true })
vim.cmd('let test#strategy = "neoterm"')
vim.cmd('let test#python#runner = "pytest"')

------------------------------------------------------------------
-- neoterm
------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<c-t>", ':T echo "Howdy"<CR>', {})
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_default_mod = "belowright"
vim.g.neoterm_size = 15

------------------------------------------------------------------
-- Tagbar options
------------------------------------------------------------------
vim.api.nvim_set_keymap("n", "<F9>", ":TagbarToggle<CR>", { noremap = true, silent = true })

------------------------------------------------------------------
-- neoformat
------------------------------------------------------------------
vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])

vim.g.neoformat_python_black = {
	exe = "black",
	stdin = 1,
	args = { "--line-length 120", "-q", "-" },
}

vim.g.neoformat_ruby_rubocop = {
	exe = "bundle",
	args = {
		"exec",
		"rubocop",
		"--auto-correct",
		"stdin",
		'"%:p"',
		"2>/dev/null",
		"|",
		'sed "1,/^====================$/d"',
	},
	stdin = 1,
	stderr = 1,
}

vim.g.neoformat_go_goimports = {
	exe = "goimports",
	stdin = 0,
}

vim.g.neoformat_markdown_prettier = {
	exe = "prettier",
	args = { "--stdin-filepath", '"%:p"' },
	stdin = 1,
}

vim.g.neoformat_enabled_python = { "black" }
vim.g.neoformat_enabled_javascript = { "prettier" }
vim.g.neoformat_enabled_css = { "prettier" }
vim.g.neoformat_enabled_html = { "prettier" }
vim.g.neoformat_enabled_markdown = { "prettier" }
vim.g.neoformat_enabled_ruby = {}
vim.g.neoformat_enabled_eruby = {}
vim.g.neoformat_enabled_go = { "goimports" }
vim.g.neoformat_enabled_lua = { "stylua" }
vim.g.neoformat_enabled_rust = { "rustfmt" }

------------------------------------------------------------------
-- Nice line numbers and syntax stuff
------------------------------------------------------------------
vim.opt.number = true
vim.opt.syntax = "enable"
vim.opt.showmatch = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 6

------------------------------------------------------------------
-- Syntastic
------------------------------------------------------------------
vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 0
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0

vim.g.syntastic_python_checkers = { "python" }
vim.g.syntastic_scss_checkers = { "sass" }
vim.cmd([[
if isdirectory("app/assets/stylesheets")
  vim.g.syntastic_scss_sass_args = "--load-path app/assets/stylesheets"
endif
]])

------------------------------------------------------------------
-- Color Scheme and right column line
------------------------------------------------------------------
vim.cmd("let base16colorspace = 16")
vim.cmd("colorscheme base16-default-dark")
vim.cmd("highlight colorcolumn ctermbg=8")
vim.cmd("highlight colorcolumn guibg=DarkBlue")
vim.opt.colorcolumn = "88"

------------------------------------------------------------------
-- Some MiniBuf options
------------------------------------------------------------------
vim.g.miniBufExplMapWindowNavVim = 1
vim.g.miniBufExplMapWindowNavArrows = 1
vim.g.miniBufExplMapCTabSwitchBufs = 1
vim.g.miniBufExplModSelTarget = 1

------------------------------------------------------------------
-- EasyMotion use _ instead of \\
------------------------------------------------------------------
vim.g.EasyMotion_leader_key = "_"

------------------------------------------------------------------
-- LaTeX options
------------------------------------------------------------------
vim.g.Tex_DefaultTargetFormat = "pdf"
vim.g.Tex_MultipleCompileFormats = "dvi,pdf"

-- IMPORTANT: win32 users will need to have 'shellslash' set so that latex
-- can be called correctly.
-- set shellslash

-- IMPORTANT: grep will sometimes skip displaying the file name if you
-- search in a singe file. This will confuse Latex-Suite. Set your grep
-- program to always generate a file-name.
vim.opt.grepprg = "grep\\ -nH\\ $*"

------------------------------------------------------------------
-- scratch
------------------------------------------------------------------
vim.g.scratch_persistence_file = HOME .. "/Downloads/scratch"

------------------------------------------------------------------
-- Language server options
------------------------------------------------------------------
-- Required for operations modifying multiple buffers like rename.
vim.opt.hidden = true

local lsp_defaults = {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function()
		vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
	end,
}

local lspconfig = require("lspconfig")

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_defaults)

vim.api.nvim_create_autocmd("User", {
	pattern = "LspAttached",
	desc = "LSP actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Displays hover information about the symbol under the cursor
		bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

		-- Jump to the definition
		bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

		-- Jump to declaration
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

		-- Lists all the implementations for the symbol under the cursor
		bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

		-- Jumps to the definition of the type symbol
		bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

		-- Lists all the references
		bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

		-- Displays a function's signature information
		--bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

		-- Renames all references to the symbol under the cursor
		bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

		-- Selects a code action available at the current cursor position
		--bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		--bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

		-- Show diagnostics in a floating window
		bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")

		-- Move to the previous diagnostic
		bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

		-- Move to the next diagnostic
		bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
	end,
})

lspconfig.sumneko_lua.setup({
	single_file_support = true,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})
lspconfig.gopls.setup({})
lspconfig.tsserver.setup({})
lspconfig.rls.setup({
	settings = {
		rust = {
			unstable_features = true,
			build_on_save = false,
			all_features = true,
		},
	},
})

------------------------------------------------------------------
-- Completion/snippets
------------------------------------------------------------------
-- Disable AutoComplPop.
vim.g.acp_enableAtStartup = 0

vim.opt.completeopt = { "menu", "menuone", "noselect" }

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local luasnip = require("luasnip")

local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),

		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		["<C-d>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<C-b>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})

local function bash(command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end

luasnip.add_snippets("all", {
	luasnip.snippet("todo", {
		luasnip.function_node(function(_, snip)
			return snip.env.LINE_COMMENT
		end, {}),
		luasnip.text_node("TODO("),
		luasnip.function_node(function(_, _)
			return bash("git config --get user.email")
		end, {}),
		luasnip.text_node(": "),
		luasnip.insert_node(0),
		luasnip.text_node(os.date("%Y-%m-%d-%H:%M:%S")),
	}),
	luasnip.snippet("date", {
		luasnip.text_node(os.date("%Y-%m-%d")),
	}),
})

------------------------------------------------------------------
-- Custom functions
------------------------------------------------------------------
-- Rg text
-- select/deselect (alt-a or alt-d to get all)
-- enter
-- cfdo %s/text to search/text to replace with/gc | update

------------------------------------------------------------------
-- Basic settings
------------------------------------------------------------------
vim.opt.compatible = false -- be iMproved
vim.opt.backspace = "2" -- allow backspacing over everything in insert mode
vim.opt.history = 500 -- keep 500 lines of command line history
vim.opt.laststatus = 2 -- always have status bar
vim.opt.encoding = "utf-8" -- Let's be modern and use a real-boy encoding
vim.opt.scrolloff = 1 -- don't let the cursor get too close to the edge
vim.opt.backup = false -- Don't keep a backup file
vim.opt.ruler = true -- the ruler on the bottom is useful
vim.opt.showcmd = true -- Show (partial) command in status line.
vim.opt.wildmenu = true -- This is used with wildmode(full) to cycle options
vim.opt.hidden = true -- Save buffers in the background (don't save on buffer switch)
vim.opt.confirm = true -- Confirm before closing unsaved buffers
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.cmd("let t_Co=256")
vim.opt.termguicolors = true

vim.api.nvim_set_keymap("n", "<C-n>", ":bn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", ":bp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":bd<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-s>", ":sort<CR>", {})

-- Nice tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true

-- Special key configurations
vim.api.nvim_set_keymap("n", "j", "gj", {})
vim.api.nvim_set_keymap("n", "k", "gk", {})

-- Spelling and search options
vim.opt.spell = false
vim.opt.spellfile = HOME .. "/.config/spell/en.utf-8.add"
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.api.nvim_set_keymap("n", "\\q", ":nohlsearch<CR>", {})

-- FILETYPE settings
vim.cmd("filetype off")
vim.cmd("filetype plugin on")
vim.cmd("filetype plugin indent on")
vim.cmd("filetype indent on")
vim.g.tex_flavor = "latex" -- Get LaTeX filetype correctly
vim.opt.omnifunc = "syntaxcomplete#Complete"

vim.cmd([[
autocmd FileType python set shiftwidth=4
autocmd FileType python set softtabstop=4
]])

------------------------------------------------------------------
-- Check for company specific configurations
------------------------------------------------------------------
vim.cmd([[
let corporate_config = $HOME."/.corporate_configs/vimrc.vim"
if filereadable(corporate_config)
  exec 'source ' . corporate_config
endif
]])

------------------------------------------------------------------
-- HELP
------------------------------------------------------------------
-- Exit terminal mode
-- <C-\><C-n>
-- vim `rg --with-file-names some_pattern`
-- :Rg search then :cdo %s/search/replace/gc
