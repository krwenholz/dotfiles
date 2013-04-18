" Basic settings
set nocompatible               " be iMproved
  
" FILETYPE settings
filetype off                   
filetype plugin on
filetype plugin indent on
filetype indent on
let g:tex_flavor='latex' " Get LaTeX filetype correctly

" Vundle settings
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle and other stuff
Bundle 'gmarik/vundle' 
Bundle 'https://github.com/Lokaltog/vim-easymotion'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'minibufexpl.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/VimClojure'
    " to finish installation go in there and type './install.sh'
Bundle 'Valloric/YouCompleteMe'
    " need the Arch package or similar to actually use it
Bundle 'Lokaltog/powerline'

" Nice tabs
set tabstop=4
set shiftwidth=4
set expandtab
set cindent
set smartindent
set autoindent

" Nice line numbers and syntax stuff
set number
syntax enable

" Color Scheme and right column line
set background=light
colorscheme solarized
highlight colorcolumn ctermbg=9
highlight colorcolumn guibg=DarkBlue
set colorcolumn=75

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

" Powerline setting
set rtp+=~/.vim/bundle/powerline/bindings/vim
set laststatus=2

" Some MiniBuf options
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Some TaskList keys
map T :TaskList<CR>
map P :TlistToggle<CR>

" EasyMotion use \ instead of \\
let g:EasyMotion_leader_key = '_'

" LaTeX options
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'

" Settings for VimClojure
let vimclojure#HighlightBuiltins=1      " Highlight Clojure's builtins
let vimclojure#ParenRainbow=1           " Rainbow parentheses'!
set t_Co=16

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

