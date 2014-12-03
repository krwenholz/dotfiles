# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep
bindkey -v

alias pingtest="ping www.google.com"

export PATH=/Users/wenholzk/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH="/apollo/env/SDETools/bin:$PATH"

export EDITOR=vim
export VISUAL=vim

# path to z
. `brew --prefix`/etc/profile.d/z.sh

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

echo "Hey there!     ツ"
