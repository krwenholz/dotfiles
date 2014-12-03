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
alias flip="/Users/wenholzk/bin/flip.universal"
alias qc="/Users/wenholzk/workspace/utils/qc.sh"

export PATH=/usr/local/bin:$PATH
export PATH=/Users/wenholzk/bin:$PATH

# path to z
#. `brew --prefix`/etc/profile.d/z.sh
#. /home/wenholzk/bin/z/z.sh

echo "Hey there!     ツ"
