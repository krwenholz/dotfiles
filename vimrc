" Set the boolean number option to true
set number
syntax enable
set background=light
colorscheme solarized
set tabstop=4
set shiftwidth=4
set expandtab
highlight colorcolumn ctermbg=9
highlight colorcolumn guibg=DarkBlue
set colorcolumn=75
set cindent
set smartindent
set autoindent
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


" Some MiniBuf options
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Some TaskList options
map T :TaskList<CR>
map P :TlistToggle<CR>

" EasyMotion use \ instead of \\
let g:EasyMotion_leader_key = '_'

" LATEX
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
filetype plugin indent on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" LaTeX should go to pdf
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'

set t_Co=16

" Settings for VimClojure
let vimclojure#HighlightBuiltins=1      " Highlight Clojure's builtins
let vimclojure#ParenRainbow=1           " Rainbow parentheses'!

" Settings for eclim
set nocompatible

" Sable
augroup filetypedetect
    au BufNewFile,BufRead *.sable setf sablecc
augroup end

