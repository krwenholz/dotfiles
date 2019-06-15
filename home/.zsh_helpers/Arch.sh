echo "Configuring Arch"

########################################################################
# Networking
########################################################################
# Add AllowUsers kyle to /etc/ssh/sshd_config
# Set PasswordAuthentication no
# Start ssh.dsocket service and edit the unit file with systemctl edit sshd.socket to reflect aforementioned port
# sudo systemctl enable ntpd.service; sudo systemctl start ntpd.service
if [[ ! -f /etc/iptables/iptables.rules ]]; then
  echo "Installing iptables rules"
  basic_rules="
*filter
:INPUT ACCEPT [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]
:TCP - [0:0]
:UDP - [0:0]
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m conntrack --ctstate INVALID -j DROP
-A INPUT -p icmp -m icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A INPUT -p udp -m conntrack --ctstate NEW -j UDP
-A INPUT -p tcp --tcp-flags FIN,SYN,RST,ACK SYN -m conntrack --ctstate NEW -j TCP
-A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
-A INPUT -p tcp -j REJECT --reject-with tcp-reset
-A INPUT -j REJECT --reject-with icmp-proto-unreachable
-A TCP -p tcp --dport 22 -j ACCEPT
# Don't limit SSH from known addresses
-A INPUT -p tcp --dport 22 -s xxx.xxx.xxx.xxx -j ACCEPT
# SSH rate limiting from unknown IP addresses
# Allow 2 chances in 10 minutes to connect, reject after that
-A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
-A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 600 --hitcount 3 -j DROP
# Allow mosh connections
-A UDP -p udp --dport 60001 -j ACCEPT
# Basic web server openings
-A TCP -p tcp --dport 80 -j ACCEPT
-A TCP -p tcp --dport 443 -j ACCEPT
-A TCP -p tcp --dport 3000 -j ACCEPT
# TUN/TAP
-A INPUT -i tun+ -j ACCEPT
-A FORWARD -i tun+ -j ACCEPT
-A INPUT -i tap+ -j ACCEPT
-A FORWARD -i tap+ -j ACCEPT
COMMIT
"
  echo $basic_rules | sudo tee -a /etc/iptables/iptables.rules
  sudo iptables-restore < /etc/iptables/iptables.rules
  sudo systemctl enable iptables.service
  sudo systemctl start iptables.service
  # add rules with `sudo iptables LINE_TO_ADD` then
  # `sudo iptables-save > /etc/iptables/iptabels.rules`
fi

#######################################################################
# Apps/utilities
########################################################################
installed=`pacman --query`
to_install=""
if [[ ! $installed == *"wget"* ]]; then
  to_install=$to_install"wget "
fi
if [[ ! $installed == *"tldr"* ]]; then
  to_install=$to_install"tldr "
fi
if [[ ! $installed == *"peek"* ]]; then
  to_install=$to_install"peek "
fi
if [[ ! $installed == *"oath-toolkit"* ]]; then
  to_install=$to_install"oath-toolkit "
fi
if [[ ! $installed == *"rustup"* ]]; then
  to_install=$to_install"rustup "
fi
if [[ ! $installed == *"ripgrep"* ]]; then
  to_install=$to_install"ripgrep "
fi
if [[ ! $installed == *"fzf"* ]]; then
  to_install=$to_install"fzf "
fi
if [[ ! $installed == *"ntp"* ]]; then
  to_install=$to_install"ntp "
fi
if [[ ! $installed == *"rclone"* ]]; then
  to_install=$to_install"rclone "
fi
if [[ ! $installed == *"tree"* ]]; then
  to_install=$to_install"tree "
fi
if [[ ! $installed == *"highlight"* ]]; then
  to_install=$to_install"highlight "
fi
if [[ ! $installed == *"unzip"* ]]; then
  to_install=$to_install"unzip "
fi
if [[ ! $installed == *"xclip"* ]]; then
  to_install=$to_install"xclip "
fi
if [[ ! $installed == *"xsel"* ]]; then
  to_install=$to_install"xsel "
fi
if [[ ! $installed == *"mosh"* ]]; then
  to_install=$to_install"mosh "
fi
if [[ ! $installed == *"iproute2"* ]]; then
  to_install=$to_install"iproute2 "
fi
if [[ ! $installed == *"htop"* ]]; then
  to_install=$to_install"htop "
fi
if [[ ! $installed == *"neovim"* ]]; then
  to_install=$to_install"neovim "
fi
if [[ ! $installed == *"openssh"* ]]; then
  to_install=$to_install"openssh "
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
if [[ ! $installed == *"hunspell-en_US"* ]]; then
  to_install=$to_install"hunspell-en_US "
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
if [[ ! $installed == *"bind-tools"* ]]; then
  to_install=$to_install"bind-tools "
fi
if [[ ! $installed == *"docker"* ]]; then
  to_install=$to_install"docker "
  to_install=$to_install"docker-ce "
  to_install=$to_install"docker-compose "
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
if [[ ! $installed == *"moreutils"* ]]; then
  to_install=$to_install"moreutils "
fi

if [ ! -z "$to_install" ]; then
  echo "Decided to install " $to_install
  # TODO: this is actually broken, but at least it tells me what's missing
  echo "You have uninstalled packages run the following:"
  echo "sudo pacman -Suy $to_install"
fi


#######################################################################
# AUR
########################################################################

# https://github.com/Jguer/yay
yayLocation=`which yay`
if [[ $yayLocation == *'not found' ]]; then
  echo "Installing yay"
  git clone https://aur.archlinux.org/yay.git $HOME/Downloads/yay
  cd yay
  makepkg -si
  cd -
fi

#git clone https://aur.archlinux.org/yay.git
# TODO: AUR install slack-desktop intellij-idea-ultimate-edition rubymine rbenv ruby-build gron-bin plantuml snapd

#######################################################################
# PIP
########################################################################
# TODO: pip install saws fpm awslogs 'python-language-server[all]' pre-commit yapf isort pycodestyle pygments --user

#######################################################################
# Ruby
########################################################################
# TODO: rbenv install 2.5.1; rbenv global 2.5.1
# TODO: gem install github, yard, solargraph, pry, hirb (yard config --gem-install-yri)

#######################################################################
# Rust
########################################################################
# TODO: rustup and cargo install nightly, cargo-edit

#######################################################################
# Other installs and inits
########################################################################

if [[ ! -d $HOME/.nvm ]]; then
  echo "Installing nvm"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

  curl -o- -L https://yarnpkg.com/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ ! -f $HOME/bin/circleci ]]; then
  curl -fLSs https://circle.ci/cli | DESTDIR=$HOME/bin bash
fi

read -d '' tmux_conf_final <<-"_EOF_"
# Vim style
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -i -p && xsel -o -p | xsel -i -b"
set-option -g history-limit 10000
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

if ! systemctl status docker.service > /dev/null; then
  sudo systemctl start docker.service
fi

if [[ `groups $USER` != *'docker'* ]]; then
  sudo groupadd docker
  sudo gpasswd -a $USER docker
  newgrp docker
fi

rclone_remotes=`rclone listremotes`
if [[ ! $rclone_remotes == *"GoogleDrive-things"* ]]; then
  echo 'GoogleDrive-things needs configuring'
  echo 'https://drive.google.com/drive/folders/1esX7uBnDR17lWj6PoAh4o7zTIh0PhKNY'
  rclone config
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
alias grep="grep --color"

TODO=$HOME/things/TODO.md
DONE_SELF=$HOME/things/DONE_SELF.md
DONE_WORK=$HOME/things/DONE_WORK.md

function things_down {
  rclone sync GoogleDrive-things: $HOME/things
}
function things_up {
  rclone sync $HOME/things GoogleDrive-things:
}
alias tedit="things_down && vim $TODO $DONE_SELF $DONE_WORK && things_up &"

function tokens {
  echo Pulling
  things_down
  echo Decrypting
  gpg --decrypt --output /tmp/fun_tokens $HOME/things/fun_tokens
  vim /tmp/fun_tokens
  echo Encrypting
  gpg --symmetric --output $HOME/things/fun_tokens /tmp/fun_tokens
  echo Uploading
  things_up &
}


function ccat {
  if [ ! -t 0 ];then
    file=/dev/stdin
  elif [ -f $1 ];then
    file=$1
  else
    echo "Usage: $0 code.c"
    echo "or e.g. head code.c|$0"
    exit 1
  fi

  pygmentize -f terminal -g $file
}

#######################################################################
# Path
########################################################################

if [[ -f $HOME/google-cloud-sdk/completion.zsh.inc ]]; then
  source $HOME/google-cloud-sdk/completion.zsh.inc
fi
if [[ -f $HOME/google-cloud-sdk/path.zsh.inc ]]; then
  source $HOME/google-cloud-sdk/path.zsh.inc
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
