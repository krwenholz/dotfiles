echo "Configuring Arch"

#######################################################################
# Apps/utilities
########################################################################
installed=`pacman --query`
to_install=""
if [[ ! $installed == *"netstat"* ]]; then
  to_install=$to_install"netstat "
fi
if [[ ! $installed == *"neovim"* ]]; then
  to_install=$to_install"neovim "
fi
if [[ ! $installed == *"ack"* ]]; then
  to_install=$to_install"ack "
fi
if [[ ! $installed == *"python-neovim"* ]]; then
  to_install=$to_install"python-neovim "
fi
if [[ ! $installed == *"python2-neovim"* ]]; then
  to_install=$to_install"python2-neovim "
fi
if [[ ! $installed == *"tmux"* ]]; then
  to_install=$to_install"tmux "
fi
if [[ ! $installed == *"firefox"* ]]; then
  to_install=$to_install"firefox "
fi
if [[ ! $installed == *"go 2"* ]]; then
  to_install=$to_install"go "
fi
if [[ ! $installed == *"inkscape"* ]]; then
  to_install=$to_install"inkscape "
fi
if [[ ! $installed == *"xsel"* ]]; then
  to_install=$to_install"xsel "
fi
if [[ ! $installed == *"terminus-font"* ]]; then
  to_install=$to_install"terminus-font "
fi
if [[ ! $installed == *"hunspell"* ]]; then
  to_install=$to_install"hunspell "
fi
if [[ ! $installed == *"hunspell-en"* ]]; then
  to_install=$to_install"hunspell-en "
fi
if [[ ! $installed == *"openvpn"* ]]; then
  to_install=$to_install"openvpn "
fi
if [[ ! $installed == *"tig"* ]]; then
  to_install=$to_install"tig "
fi
if [[ ! $installed == *"openssh"* ]]; then
  to_install=$to_install"openssh "
fi
if [[ ! $installed == *"gvim"* ]]; then
  to_install=$to_install"gvim "
fi
if [[ ! $installed == *"python-pip"* ]]; then
  to_install=$to_install"python-pip "
fi
if [[ ! $installed == *"pygmentize"* ]]; then
  to_install=$to_install"pygmentize "
fi
if [[ ! $installed == *"calibre"* ]]; then
  to_install=$to_install"calibre "
fi
if [[ ! $installed == *"jq"* ]]; then
  to_install=$to_install"jq "
fi
if [[ ! $installed == *"bluez"* ]]; then
  to_install=$to_install"bluez bluez-utils "
  # may need systemctl enable bluetooth.service
fi
if [[ ! $installed == *"diff-so-fancy"* ]]; then
  to_install=$to_install"diff-so-fancy "
fi
if [[ ! $installed == *"hub"* ]]; then
  to_install=$to_install"hub "
fi
if [[ ! $installed == *"asciinema"* ]]; then
  to_install=$to_install"asciinema "
fi
if [[ ! $installed == *"docker"* ]]; then
  to_install=$to_install"docker "
  sudo systemctl restart docker.service
fi
if [[ ! $installed == *"ttf-freefont"* ]]; then
  to_install=$to_install"ttf-freefont ttf-arphic-uming ttf-indic-otf "
fi
if [[ ! $installed == *"ipython"* ]]; then
  to_install=$to_install"ipython "
fi
if [[ ! $installed == *"terraform"* ]]; then
  to_install=$to_install"terraform "
fi
if [[ ! $installed == *"pandoc"* ]]; then
  to_install=$to_install"pandoc "
fi
if [[ ! $installed == *"postgresql"* ]]; then
  to_install=$to_install"postgresql "
fi
if [[ ! $installed == *"fwupd"* ]]; then
  # https://github.com/hughsie/fwupd
  to_install=$to_install"fwupd "
fi

if [ ! -z "$to_install" ]; then
  echo "Decided to install " $to_install
  # TODO: this is actually broken, but at least it tells me what's missing
  echo "You have uninstalled packages run the following:"
  echo "sudo pacman -Suy $to_install"
fi

# TODO: AUR install slack-desktop intellij-idea-ultimate-edition rubymine rbenv ruby-build gron-bin plantuml 
# TODO: pip install saws gnome-shell-extension-extended-gestures-git fpm touchegg-git touchegg-gce-git awslogs 'python-language-server[all]' pre-commit yapf isort pycodestyle --user
# TODO: gem install github, yard, solargraph (yard config --gem-install-yri)
# TODO: docker pull asciinema/asciicast2gif
# TODO: go get -u github.com/variadico/noti/cmd/noti

read -d '' tmux_conf_final <<-"_EOF_"
# Vim style
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -i -p && xsel -o -p | xsel -i -b"
set -sg escape-time 10
_EOF_

tmux_conf=`cat ~/.tmux.conf`
if [[ "$tmux_conf" != $tmux_conf_final ]]; then
  echo "Correcting tmux.conf"
  rm -f ~/.tmux.conf
  echo $tmux_conf_final > ~/.tmux.conf
fi

if [[ ! -f $HOME/bin/ngrok ]]; then
  echo "Installing ngrok, consider updating the download URL"
  cd $HOME/Downloads
  curl -O https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
  unzip ngrok-stable-linux-amd64.zip
  cp ngrok $HOME/bin
fi

#######################################################################
# Activations
########################################################################
eval "$(rbenv init -)"

running_pg=`systemctl is-enabled postgresql.service`
if [[ "$running_pg" == 'disabled' ]]; then
  echo "WARNING: You need to initialize postgres"
  # sudo -u postgres -i
  # initdb -D "/var/lib/postgres/data/"
  # exit
  # sudo systemctl enable postgresql.service
  # sudo systemctl start postgresql.service
  # sudo -u postgres -i
  # createuser -s kyle
  # createdb kyle
fi

#######################################################################
# Aliases
########################################################################
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias github='~/.gem/ruby/2.5.0/bin/github'
alias asciicast2gif="sudo docker run --rm -v $PWD:/data asciinema/asciicast2gif $1"
alias image-viewer='eog'

#######################################################################
# Path
########################################################################
# TODO if necessary


#######################################################################
# Notes
########################################################################
# https://wiki.archlinux.org/index.php/Network_Time_Protocol_daemon#Usage
# https://wiki.archlinux.org/index.php/Installation_guide#Root_password
# https://wiki.archlinux.org/index.php/Dhcpcd#Static_profile
# https://wiki.archlinux.org/index.php/Users_and_groups#User_groups
# https://wiki.archlinux.org/index.php/General_recommendations#System_administration
# https://wiki.archlinux.org/index.php/Server
