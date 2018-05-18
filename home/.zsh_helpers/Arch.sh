echo "Configuring Arch"

#######################################################################
# Apps/utilities
########################################################################
installed=`pacman --query --explicit`
to_install=""
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


if [ ! -z "$to_install" ]; then
  echo "Decided to install " $to_install
  # TODO: this is actually broken, but at least it tells me what's missing
  sudo pacman -S $to_install
fi

# TODO: AUR install slack-desktop intellij-idea-ultimate-edition rubymine rbenv ruby-build gron-bin
# TODO: pip install saws gnome-shell-extension-extended-gestures-git fpm touchegg-git touchegg-gce-git
# TODO: install this with some pacman/makefile hackery https://github.com/robbi5/magictrackpad2-dkms
# TODO: install gnome 3 Workspace Grid
# TODO: gem install github
# TODO: docker pull asciinema/asciicast2gif

read -d '' tmux_conf_final <<-"_EOF_"
# Vim style
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -i -p && xsel -o -p | xsel -i -b"
_EOF_

tmux_conf=`cat ~/.tmux.conf`
if [[ "$tmux_conf" != $tmux_conf_final ]]; then
  echo "Correcting tmux.conf"
  rm -f ~/.tmux.conf
  echo $tmux_conf_final > ~/.tmux.conf
fi

#######################################################################
# Activations
########################################################################
eval "$(rbenv init -)"

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
