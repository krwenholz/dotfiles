echo "Configuring Fedora"
# Configuration dir
mkdir $HOME/configs 

# Solarized for Gnome Terminal
if [ ! -d $HOME/configs/gnome-terminal-colors-solarized ]; then
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized $HOME/Downloads
  $/HOME/configs/gnome-terminal-colors-solarized/install.sh
  $/HOME/configs/gnome-terminal-colors-solarized/set_light.sh
fi

echo "Installing useful packages for Fedora"
TO_INSTALL=""
if [ ! -f /usr/bin/vim ]; then
 TO_INSTALL=TO_INSTALL + " vim"
fi
if [ ! -f /usr/bin/nano ]; then
 TO_INSTALL=TO_INSTALL + " nano"
fi
if [ ! -f /usr/bin/tig ]; then
  TO_INSTALL=TO_INSTALL + "tig"
fi

if [ TO_INSTALL!="" ]; then
  sudo dnf install TO_INSTALL
fi

export JAVA_HOME=/etc/alternatives/jre_openjdk
export PATH=PATH:$HOME/bin/idea-IC-143.382.35/bin
