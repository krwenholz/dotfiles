tigrc=`cat $HOME/.tigrc`
if [[ $tigrc != *"set vertical-split = no"* ]]; then
  echo "set vertical-split = no" >> $HOME/.tigrc
fi

if [ ! -f /usr/local/bin/tmux ]; then
  echo "Installing tmux"
  brew install tmux
fi
