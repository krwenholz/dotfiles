echo "Configuring Fedora"
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
if [ ! -f /usr/bin/vim ]; then
  to_install=$to_install + " vim"
fi
if [ ! -f /usr/bin/nano ]; then
  to_install=$to_install + " nano"
fi
if [ ! -f /usr/bin/tig ]; then
  to_install=$to_install + " tig"
fi
if [ ! -f /usr/bin/vim ]; then
  to_install=$to_install + " vim-enhanced"
fi

if [ "$to_install" -ne "" ]; then
  echo "Decided to install " $to_install
  sudo dnf install $to_install
fi

#Check awscli installation with pip3
if [ ! -f /usr/bin/aws ]; then
    echo "Installing awscli"
    sudo pip3 install awscli
fi

export JAVA_HOME=/etc/alternatives/java_sdk_openjdk
export PATH=$PATH:$HOME/bin/idea-IC-143.382.35/bin
alias intellij=$HOME/bin/idea-IC-143.382.35/bin/idea.sh
