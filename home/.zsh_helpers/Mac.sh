tigrc=`cat $HOME/.tigrc`
if [[ $tigrc != *"set vertical-split = no"* ]]; then
  echo "set vertical-split = no" >> $HOME/.tigrc
fi

if [ ! -f /usr/local/bin/mono ]; then
  echo "Installing mono for F#"
  brew install mono
fi

if [ ! -d /Applications/Visual\ Studio\ Code.app/ ]; then
  echo "TODO: we should install Visual Studio Code"
fi

if [ ! -f /Users/$USER/Library/Application Support/Code/User/settings.json ]; then
  echo "TODO: Install VS Code settings"
fi
