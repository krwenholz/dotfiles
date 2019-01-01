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
pacman=`which pacman`
lsb_exists=`which lsb_release`
if [[ $pacman == '/usr/bin/pacman' ]]; then
  host='arch'
elif [[ $platform == 'linux' ]]; then
  host=$HOSTNAME
elif [[ $platform == 'mac' ]]; then
  host=$HOST
elif [[ lsb_exists == 0 ]]; then
  ubuntu=`lsb_release -a`
  if [[ $ubuntu == *"Ubuntu"* ]]; then
    host='ubuntu'
  fi
fi

echo "Using platform $platform on host $host"

if [[ -d $HOME/.corporate_configs ]]; then
    echo "Found a corporate configuration"
    source $HOME/.corporate_configs/zsh_config.sh
fi

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
set editing-mode vi
set keymap vi

########################################################################
# Aliases
########################################################################
alias vim=nvim
alias pingtest="ping -c 3 www.google.com"
alias gist="git status"
alias gamit="git commit --amend --no-edit"
alias git-personal='git config user.email "kyle@krwenholz.com" && git config user.name "Kyle R Wenholz"'
alias gem-run="$HOME/.gem/ruby/2.5.0/bin/$1"
alias my-ip="ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print \$2}' | cut -f1  -d'/'"
alias todos="rg --hidden --follow --glob '!.(git|hg|svn)' -e 'TODO\(kyle\)'"
alias penv="source venv/bin/activate"
function git-update {
  current_branch=`git rev-parse --abbrev-ref HEAD`
  echo "Updating branch $current_branch"
  git checkout master
  git fetch origin master
  git rebase origin/master
  git checkout $current_branch
  git rebase master
}
function ipython {
  if [[ -f bin/ipython ]]; then
    bin/ipython
  else
    python3 -m IPython
  fi
}

########################################################################
# System variables
########################################################################
export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color #TODO: I still don't have color after adding this
export GOPATH=$HOME/gocode

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
    mkdir -p $HOME/.vim/colors
fi

# Vundle
if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
    echo "Initializing Vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

if [[ ! -f $HOME/.vim/colors/base16-pastel-krwenholz.vim ]]; then
  if [[ ! -f $HOME/Source/base16-colors/output/vim/colors/base16-pastel-krwenholz.vim ]]; then
    git clone https://github.com/krwenholz/base16-colors.git $HOME/Source/base16-colors
  fi
  cp $HOME/Source/base16-colors/output/vim/colors/base16-pastel-krwenholz.vim $HOME/.vim/colors/base16-pastel-krwenholz.vim
fi

# Inconsolata
if [[ $platform != *'mac'* ]]; then
  fonts=`fc-list`
  if [[ $fonts != *'Inconsolata'* ]]; then
      mkdir -p $HOME/Downloads/fonts
      git clone https://github.com/powerline/fonts.git $HOME/Downloads/fonts
      cd $HOME/Downloads/fonts
      $HOME/Downloads/fonts/install.sh
      fc-cache -fv
  fi
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# A bunch of language stuff #
#############################

python3Location=`which python3`
if [[ $python3Location != *'not found' ]]; then
    #TODO: I would like to install ptpython
fi

if [ ! -d $HOME/gocode ]; then
  echo "Creating gocode directory"
  mkdir -p $HOME/gocode/bin
fi

if [[ ! -f $HOME/.gitconfig_local ]]; then
    echo "Copying gitconfig_default to gitconfig_local"
    cp $HOME/.gitconfig_default $HOME/.gitconfig_local
fi

########################################################################
# Colors
########################################################################
BASE16_SHELL="$HOME/.config/base16-shell/"
if [[ ! -f $HOME/.config/base16-shell/profile_helper.sh ]]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
base16_default-dark

########################################################################
# PATH
########################################################################
export PATH=/usr/kerberos/bin:$PATH:/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:$HOME/bin:
export PATH=$HOME/.local/bin:$HOME/gocode/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/Kyle/Downloads/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/Kyle/Downloads/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/Kyle/Downloads/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/Kyle/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

########################################################################
# FZF
########################################################################
if [[ -d /usr/share/fzf ]]; then
  echo "Sourcing fzf"
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.(git|hg|svg)/*"'
export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null ||
cat {} || tree -C {}) 2> /dev/null | head -100'"

########################################################################
# OS helpers
########################################################################
if [[ $platform == 'linux' && $host == *"fedora"* ]]; then
    source $HOME/.zsh_helpers/Fedora.sh
fi
if [[ $platform == 'linux' && $host == *"ubuntu"* ]]; then
    source $HOME/.zsh_helpers/Ubuntu.sh
fi
if [[ $platform == 'linux' && $host == *"arch"* ]]; then
    source $HOME/.zsh_helpers/Arch.sh
fi
if [[ $platform == 'mac' ]]; then
    source $HOME/.zsh_helpers/Mac.sh
fi

########################################################################
# Greeting
########################################################################

stty erase '^?'

echo "Hey there! ツ"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
