# Configuration dir
mkdir $HOME/configs 

# Solarized for Gnome Terminal
if [ ! -d $HOME/configs/gnome-terminal-colors-solarized ]; then
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized $HOME/Downloads
  $/HOME/configs/gnome-terminal-colors-solarized/install.sh
  $/HOME/configs/gnome-terminal-colors-solarized/set_light.sh
fi
