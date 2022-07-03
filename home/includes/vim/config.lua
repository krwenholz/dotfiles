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

vim.g.fzf_colors =
       { fg =      {"fg", "Normal"},
       bg =      {"bg", "Normal"},
       hl =      {"fg", "Comment"},
       info =    {"fg", "PreProc"},
       border =  {"fg", "Ignore"},
       prompt =  {"fg", "Conditional"},
       pointer = {"fg", "Exception"},
       marker =  {"fg", "Keyword"},
       spinner = {"fg", "Label"},
       header =  {"fg", "Comment"} }

vim.g.fzf_colors["fg+"] =     {"fg", "CursorLine", "CursorColumn", "Normal"}
vim.g.fzf_colors["bg+"] =     {"bg", "CursorLine", "CursorColumn"}
vim.g.fzf_colors["hl+"] =     {"fg", "Statement"},

vim.cmd([[
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
]])

-- Enable per-command history.
-- CTRL-N and CTRL-P will be automatically bound to next-history and
-- previous-history instead of down and up. If you don't like the change,
-- explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
vim.g.fzf_history_dir = HOME .. "/.local/share/fzf-history"

vim.api.nvim_set_keymap(
      "n",
      "\f",
      ":Find<CR>",
      { silent = true }
      )
vim.api.nvim_set_keymap(
      "n",
      "<c-f>",
      ":Files<CR>",
      { silent = true }
      )

------------------------------------------------------------------
-- vim-test
------------------------------------------------------------------
vim.api.nvim_set_keymap(
      "n",
      "t<c-n>",
      ":TestNearest<CR>",
      { silent = true }
      )
vim.api.nvim_set_keymap(
      "n",
      "t<c-f>",
      ":TestFile<CR>",
      { silent = true }
      )
vim.api.nvim_set_keymap(
      "n",
      "t<c-s>",
      ":TestSuite<CR>",
      { silent = true }
      )
vim.api.nvim_set_keymap(
      "n",
      "t<c-l>",
      ":TestLast<CR>",
      { silent = true }
      )
vim.api.nvim_set_keymap(
      "n",
      "t<c-g>",
      ":TestVisit<CR>",
      { silent = true }
      )
vim.cmd('let test#strategy = "neoterm"')
vim.cmd('let test#python#runner = "pytest"')

------------------------------------------------------------------
-- neoterm
------------------------------------------------------------------
vim.api.nvim_set_keymap(
      "n",
      "<c-t>",
      ':T echo "Howdy"<CR>',
      {}
      )
vim.g.neoterm_autoscroll = 1
vim.g.neoterm_default_mod = "belowright"
vim.g.neoterm_size = 15

------------------------------------------------------------------
-- Tagbar options
------------------------------------------------------------------
vim.api.nvim_set_keymap(
      "n",
      "<F9>",
      ":TagbarToggle<CR>",
      { noremap = true, silent = true}
      )

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
      exe = 'black',
      stdin = 1,
      args = {'--line-length 120', '-q', '-'}
      }

vim.g.neoformat_ruby_rubocop = {
       exe = 'bundle',
       args = {'exec', 'rubocop', '--auto-correct', 'stdin', '"%:p"', '2>/dev/null', '|', 'sed "1,/^====================$/d"'},
       stdin = 1,
       stderr = 1
      }

vim.g.neoformat_go_goimports = {
       exe = 'goimports',
       stdin = 0,
      }

vim.g.neoformat_markdown_prettier = {
       exe = 'prettier',
       args = {'--stdin-filepath', '"%:p"'},
       stdin = 1,
      }

vim.g.neoformat_enabled_python = {'black'}
vim.g.neoformat_enabled_javascript = {'prettier'}
vim.g.neoformat_enabled_css = {'prettier'}
vim.g.neoformat_enabled_html = {'prettier'}
vim.g.neoformat_enabled_markdown = {'prettier'}
vim.g.neoformat_enabled_ruby = {}
vim.g.neoformat_enabled_eruby = {}
vim.g.neoformat_enabled_go = {'goimports'}


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

vim.g.syntastic_python_checkers = {"python"}
vim.g.syntastic_scss_checkers = {"sass"}
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
vim.g.EasyMotion_leader_key = '_'

------------------------------------------------------------------
-- LaTeX options
------------------------------------------------------------------
vim.g.Tex_DefaultTargetFormat='pdf'
vim.g.Tex_MultipleCompileFormats='dvi,pdf'

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
vim.g.scratch_persistence_file = HOME .. '/Downloads/scratch'

------------------------------------------------------------------
-- Completion options
------------------------------------------------------------------
-- Disable AutoComplPop.
vim.g.acp_enableAtStartup = 0

-- Required for operations modifying multiple buffers like rename.
vim.opt.hidden = true

-- nnoremap <F5> :call LanguageClient_contextMenu()<CR>
-- Or map each action separately
-- nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
-- nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
-- nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
-- nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>

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
vim.opt.compatible = false          -- be iMproved
vim.opt.backspace = "2"           -- allow backspacing over everything in insert mode
vim.opt.history=500           -- keep 500 lines of command line history
vim.opt.laststatus=2          -- always have status bar
vim.opt.encoding="utf-8"        -- Let's be modern and use a real-boy encoding
vim.opt.scrolloff=1           -- don't let the cursor get too close to the edge
vim.opt.backup = false              -- Don't keep a backup file
vim.opt.ruler = true                -- the ruler on the bottom is useful
vim.opt.showcmd = true               -- Show (partial) command in status line.
vim.opt.wildmenu = true-- This is used with wildmode(full) to cycle options
vim.opt.hidden = true                -- Save buffers in the background (don't save on buffer switch)
vim.opt.confirm = true               -- Confirm before closing unsaved buffers
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.cmd("let t_Co=256")
vim.opt.termguicolors = true

vim.api.nvim_set_keymap(
      "n",
      "<c-n>",
      ':bn<CR>',
      { noremap = true }
      )
vim.api.nvim_set_keymap(
      "n",
      "<c-l>",
      ':bl<CR>',
      { noremap = true }
      )
vim.api.nvim_set_keymap(
      "n",
      "<c-k>",
      ':bd<CR>',
      { noremap = true }
      )
vim.api.nvim_set_keymap(
      "v",
      "<C-s>",
      ':sort<CR>',
      {}
      )

-- Nice tabs
vim.opt.expandtab = true
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.softtabstop=2
vim.opt.autoindent = true

-- Special key configurations
vim.api.nvim_set_keymap(
      "n",
      "j",
      'gj',
      {}
      )
vim.api.nvim_set_keymap(
      "n",
      "k",
      'gk',
      {}
      )

-- Spelling and search options
vim.opt.spell = false
vim.opt.spellfile= HOME .. "/.config/spell/en.utf-8.add"
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.api.nvim_set_keymap(
      "n",
      "\\q",
      ':nohlsearch<CR>',
      {}
      )


-- FILETYPE settings
vim.cmd("filetype off")
vim.cmd("filetype plugin on")
vim.cmd("filetype plugin indent on")
vim.cmd("filetype indent on")
vim.g.tex_flavor='latex' -- Get LaTeX filetype correctly
vim.opt.omnifunc="syntaxcomplete#Complete"

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
