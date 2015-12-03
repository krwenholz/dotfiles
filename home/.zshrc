#######################################################################
# OS specific settings
########################################################################
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
fi

host='unknown'
if [[ $platform == 'linux' ]]; then
    host=$HOSTNAME
elif [[ $platform == 'mac' ]]; then
    host=$HOST
fi

echo "Using platform $platform on host $host"

if [[ $platform == 'linux' && $host == *"amazon"* ]]; then
    source $HOME/.zsh_helpers/AmazonLinuxSetup.sh
fi
if [[ $platform == 'mac' && $host == *"amazon"* ]]; then
    source $HOME/.zsh_helpers/AmazonMacSetup.sh
fi

#######################################################################
# Dependencies to download and source
########################################################################
if [ ! -d $HOME/Downloads ]; then
    mkdir Downloads
fi
if [ ! -d $HOME/bin ]; then
    echo "Creating bin directory"
    mkdir $HOME/bin
fi

# zprezto
if [ ! -f $HOME/.zprezto/init.zsh ]; then
    echo "Installing Zprezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    # TODO: this may overwrite my zprezto stuff
fi

# Vim #
#######
get_vimrc() {
    echo "Copying remote vimrc to local"
    install_dotfiles
    cp $HOME/Downloads/dotfiles/home/.vimrc $HOME/.vimrc
}

if [ -f $HOME/.vimrc ]; then
    grep -q -i wenholz $HOME/.vimrc
    if [ $? -eq 1 ]; then
        get_vimrc
    fi
else
    get_vimrc
fi

if [ ! -d $HOME/.vim/bundle ]; then
    mkdir -p $HOME/.vim/bundle
fi

# Vundle
if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
    echo "Initializing Vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

# Inconsolata
fonts=`fc-list`
if [[ $fonts != *'Inconsolata'* ]]; then
    mkdir -p $HOME/Downloads/fonts
    git clone https://github.com/powerline/fonts.git $HOME/Downloads/fonts
    cd $HOME/Downloads/fonts
    $HOME/Downloads/fonts/install.sh
    fc-cache -fv
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

########################################################################
# General
########################################################################
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep
bindkey -v

########################################################################
# Aliases
########################################################################
alias pingtest="ping -c 3 www.google.com"

alias gist="git status"

########################################################################
# PATH
########################################################################
export PATH=/usr/kerberos/bin:$PATH:/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/home/wenholzk/bin

########################################################################
# System variables 
########################################################################
export EDITOR=vim
export VISUAL=vim
export TERM=xterm-256color #TODO: I still don't have color after adding this

########################################################################
# Company specific setup
########################################################################
if [[ $HOST == *"amazon"* ]]; then
    source $HOME/.zsh_helpers/AmazonSetup.sh
fi

########################################################################
# Greeting
########################################################################

stty erase '^?'

echo "Hey there! ツ"

#TODO: I would like to install ptpython
