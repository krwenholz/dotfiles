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
    Plugin 'sjl/gundo.vim'
    Plugin 'kien/ctrlp.vim'
    Plugin 'alfredodeza/pytest.vim'
    " Plugin 'scrooloose/syntastic'
    " Completion
    Plugin 'Shougo/neocomplete'
    Plugin 'Shougo/neosnippet'
    Plugin 'Shougo/neosnippet-snippets'
    " Syntax
    Plugin 'natew/ftl-vim-syntax'
    Plugin 'nvie/vim-flake8'
    Plugin 'bronson/vim-trailing-whitespace'
call vundle#end()

" Syntastic
" let g:syntastic_java_javac_config_file_enabled=1

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/bin/*,*.class,*/eclipse-bin/*     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_close_on_revert = 1

" Tagbar options
nnoremap <silent> <F9> :TagbarToggle<CR>

" Color Scheme and right column line
set background=dark
colorscheme solarized
highlight colorcolumn ctermbg=9
highlight colorcolumn guibg=DarkBlue
set colorcolumn=75

" Powerline setting
" set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim

" Some MiniBuf options
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Some TaskList keys
map T :TaskList<CR>
" map P :TlistToggle<CR>

" EasyMotion use \ instead of \\
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
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Default # of completions is 100, that's crazy.
let g:neocomplete#max_list = 20

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" Close popup by <Space>.
" inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>""

" AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

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


" Nice tabs
set tabstop=2
set shiftwidth=2
set expandtab
set cindent
set smartindent
set autoindent

" Nice line numbers and syntax stuff
set number
syntax enable
set showmatch             " Show matching brackets.

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
else
  echo "Not loading any corporate configs"
endif
