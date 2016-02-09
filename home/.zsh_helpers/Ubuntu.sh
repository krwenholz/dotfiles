# check if f.lux is installed
# cd ~/Downloads
# wget https://justgetflux.com/linux/xflux64.tgz
# tar -xzvf xflux64.tgz
# now we have an executable, but it says it won't work on my display
# cd ~

echo "Configuring Ubuntu"
# Configuration dir
if [ ! -d $HOME/configs ]; then
    mkdir $HOME/configs 
fi

# Solarized for Gnome Terminal
if [ ! -d $HOME/configs/gnome-terminal-colors-solarized ]; then
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized $HOME/configs/gnome-terminal-colors-solarized
  $HOME/configs/gnome-terminal-colors-solarized/install.sh
fi

to_install=""
if [ ! -f /usr/bin/nano ]; then
  nano="nano "
  to_install=$to_install$nano
fi
if [ ! -f /usr/bin/tig ]; then
  tig="tig "
  to_install=$to_install$tig
fi
if [ ! -f /usr/bin/vim ]; then
  vim="vim-enhanced "
  to_install=$to_install$vim
fi

if [ ! -z "$to_install" ]; then
  echo "Decided to install " $to_install
  sudo apt-get install $to_install
fi

if [[ ! -f /usr/share/applications/intellij.desktop ]]; then
  sudo cp $HOME/bin/intellij.desktop /usr/share/applications
  sudo chmod 644 /usr/share/applications/intellij.desktop
fi
