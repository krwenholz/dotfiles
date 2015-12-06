# Configuration dir
mkdir $HOME/configs 

# Solarized for Gnome Terminal
if [ ! -d $HOME/configs/gnome-terminal-colors-solarized ]; then
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized $HOME/Downloads
  $/HOME/configs/gnome-terminal-colors-solarized/install.sh
  $/HOME/configs/gnome-terminal-colors-solarized/set_light.sh
fi

export JAVA_HOME=/etc/alternatives/jre_openjdk
export PATH=PATH:$HOME/bin/idea-IC-143.382.35/bin
