tigrc=`cat $HOME/.tigrc`
if [[ $tigrc != *"set vertical-split = no"* ]]; then
  echo "set vertical-split = no" >> $HOME/.tigrc
fi

#######################################################################
# Brew Apps/utilities
########################################################################
to_install=""
if [ ! -f /usr/local/bin/tmux ]; then
  brew_tmux="tmux "
  to_install=$to_install$brew_tmux
fi

if [ ! -f /usr/local/bin/terraform ]; then
  brew_terraform="terraform "
  to_install=$to_install$brew_terraform
fi

if [ ! -f /usr/local/bin/go ]; then
  brew_go="go "
  to_install=$to_install$brew_go
fi

if [ ! -f /usr/local/bin/reattach-to-user-namespace ]; then
  brew_reattach="reattach-to-user-namespace"
  to_install=$to_install$brew_reattach
fi

if [ ! -z "$to_install" ]; then
  echo "Decided to install " $to_install
  brew install $to_install
fi

tmux_conf=`cat ~/.tmux.conf`
if [[ "$tmux_conf" != *'reattach-to-user-namespace'* ]]; then
  tmux_conf='set-option -g default-command "reattach-to-user-namespace -l zsh"'$tmux_conf
  rm -f ~/.tmux.conf
  echo $tmux_conf > ~/.tmux.conf
fi
