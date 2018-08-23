" Kyle Wenholz's vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle settings and packages
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle and other stuff
      Plugin 'gmarik/Vundle.vim'
      Plugin 'https://github.com/Lokaltog/vim-easymotion'
      Plugin 'vim-scripts/TaskList.vim'
      Plugin 'altercation/vim-colors-solarized'
      Plugin 'bling/vim-airline'
      Plugin 'vim-scripts/scratch.vim'
    " Some awesome Git helpers
      Plugin 'fugitive.vim'
      Plugin 'tpope/vim-git'
    " ide type stuff
      Plugin 'majutsushi/tagbar'
      Plugin 'Raimondi/delimitMate'
      Plugin 'scrooloose/nerdtree'
      Plugin 'tomtom/tcomment_vim'
      Plugin 'kien/ctrlp.vim'
      Plugin 'alfredodeza/pytest.vim'
      Plugin 'tpope/vim-fireplace'
      Plugin 'janko-m/vim-test'
      Plugin 'kassio/neoterm'
    " Completion
      Plugin 'Shougo/deoplete.nvim'
      Plugin 'Shougo/neosnippet'
      Plugin 'Shougo/neosnippet-snippets'
      Plugin 'tpope/vim-endwise'
    " Syntax
      Plugin 'natew/ftl-vim-syntax'
      Plugin 'nvie/vim-flake8'
      Plugin 'bronson/vim-trailing-whitespace'
      Plugin 'ElmCast/elm-vim'
      Plugin 'raichoo/purescript-vim'
call vundle#end()

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1

" CtrlP
let g:ctrlp_map = '<c-p>'
nnoremap <silent> <c-f> :CtrlP<CR>
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:20'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/bin/*,*.class,*/eclipse-bin/*,*/magicjar/*
set wildignore+=*/bower_components/*,*/node_modules/*,*/elm-stuff/*
set wildignore+=*/lib/python*/*,*/lib64/python*/*
set wildignore+=*/public/packs/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" vim-test
nmap <silent> t<c-n> :TestNearest<CR> " t Ctrl+n
nmap <silent> t<c-f> :TestFile<CR>    " t Ctrl+f
nmap <silent> t<c-s> :TestSuite<CR>   " t Ctrl+s
nmap <silent> t<c-l> :TestLast<CR>    " t Ctrl+l
nmap <silent> t<c-g> :TestVisit<CR>   " t Ctrl+g
let test#strategy = "neoterm"

" neoterm
let g:neoterm_autoscroll = 1
let g:neoterm_default_mod = 'belowright'
let g:neoterm_size = 15

" Tagbar options
nnoremap <silent> <F9> :TagbarToggle<CR>

" Nice line numbers and syntax stuff
set number
syntax enable
set showmatch             " Show matching brackets.

" Color Scheme and right column line
set background=light
colorscheme solarized
highlight colorcolumn ctermbg=7
highlight colorcolumn guibg=DarkBlue
set colorcolumn=88

" Some MiniBuf options
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Some TaskList keys
map T :TaskList<CR>
" map P :TlistToggle<CR>

" EasyMotion use _ instead of \\
let g:EasyMotion_leader_key = '_'

" LaTeX options
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
" set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" Sable plugin options
augroup filetypedetect
    au BufNewFile,BufRead *.sable setf sablecc
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
        \ 'smart_case': v:true,
        \ 'max_list': 100,
        \ 'sources': { 'default' : '', 'vimshell' : $HOME.'/.vimshell_hist', 'scheme' : $HOME.'/.gosh_completions' },
        \ 'min_pattern_length': 3,
        \ 'autocomplete_delay': 100,
        \ })

"" neosnippets
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" elm-format
let g:elm_format_autosave = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible          " be iMproved
set backspace=2           " allow backspacing over everything in insert mode
set history=50            " keep 50 lines of command line history
set laststatus=2          " always have status bar
set encoding=utf-8        " Let's be modern and use a real-boy encoding
set scrolloff=2           " dont let the curser get too close to the edge
set nobackup              " Don't keep a backup file
set ruler                 " the ruler on the bottom is useful
set showcmd               " Show (partial) command in status line.
set wildmenu              " This is used with wildmode(full) to cycle options
set hidden                " Save buffers in the background (don't save on buffer switch)
set confirm               " Confirm before closing unsaved buffers
set t_Co=256

nnoremap <c-n> :bn<CR>
nnoremap <c-l> :bp<CR>
nnoremap <c-k> :bd<CR>

" Nice tabs
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" Special key configurations
nmap j gj
nmap k gk
nmap _p :set paste!<CR>

" Spelling and search options
set spell
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap \q  :nohlsearch<CR>


" FILETYPE settings
filetype off
filetype plugin on
filetype plugin indent on
filetype indent on
let g:tex_flavor='latex' " Get LaTeX filetype correctly
set omnifunc=syntaxcomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check for company specific configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let corporate_config = $HOME."/.corporate_configs/vimrc.vim"
if filereadable(corporate_config)
  exec 'source ' . corporate_config
endif
