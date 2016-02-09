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
ubuntu=`lsb_release -a`
if [[ ubuntu == *"Ubuntu"* ]]; then
    host='ubuntu'
fi

echo "Using platform $platform on host $host"

if [[ -d $HOME/.coporate_configs ]]; then
    source $HOME/.corporate_configs/zsh_config.sh
fi
if [[ $platform == 'linux' && $host == *"fedora"* ]]; then
    source $HOME/.zsh_helpers/Fedora.sh
fi
if [[ $platform == 'linux' && $host == *"ubuntu"* ]]; then
    source $HOME/.zsh_helpers/Ubuntu.sh
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
    cd $HOME/.zprezto
    git init
    git remote add origin https://github.com/sorin-ionescu/prezto.git
    git fetch
    git checkout -t origin/master
    git pull && git submodule update --init --recursive
    cd $HOME
fi

# Vim #
#######
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
if [[ -f $HOME/.zprezto/init.zsh ]]; then
    echo "Sourcing zprezto"
    source $HOME/.zprezto/init.zsh
fi

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
# Greeting
########################################################################

stty erase '^?'

echo "Hey there! ツ"

#TODO: I would like to install ptpython
