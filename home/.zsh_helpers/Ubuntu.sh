echo "Configuring Ubuntu"

if [[ ! -d $HOME/bin/sources/diff-so-fancy ]]; then
  mkdir -p $HOME/bin/sources
  git clone https://github.com/so-fancy/diff-so-fancy $HOME/bin/sources/diff-so-fancy
fi
export PATH="$HOME/bin/sources/diff-so-fancy":$PATH

#######################################################################
# Rust
########################################################################
# TODO: rustup && cargo install nightly cargo-edit

#######################################################################
# Node
########################################################################
# TODO(kyle): install -g tldr
if [[ ! -d $HOME/.nvm ]]; then
  echo "Installing nvm"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

  curl -o- -L https://yarnpkg.com/install.sh | bash
fi

#######################################################################
# Other installs and inits
########################################################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ ! -f $HOME/bin/circleci ]]; then
  curl -fLSs https://circle.ci/cli | DESTDIR=$HOME/bin bash
fi

read -d '' tmux_conf_final <<-"_EOF_"
# Vim style
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -i -p && xsel -o -p | xsel -i -b"
set-option -g history-limit 100000
set -sg escape-time 10
bind c   new-window   -c    "#{pane_current_path}"
bind '"' split-window -c    "#{pane_current_path}"
bind %   split-window -h -c "#{pane_current_path}"
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

#######################################################################
# OpenVPN
########################################################################
# if [[ ! -f /etc/openvpn/client.up ]]; then
#   echo "TODO: You need to install the OpenVPN up and down DNS scripts"
#   # cat /usr/share/openvpn/contrib/pull-resolv-conf/client.up > /etc/openvpn/client.up
#   # cat /usr/share/openvpn/contrib/pull-resolv-conf/client.down > /etc/openvpn/client.down
#   # Then edit client configs with the commands
# fi

#######################################################################
# Aliases
########################################################################
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias image-viewer='eog'
alias grep="grep --color"
alias netstat="tldr ss"
alias iwconfig="tldr iw"
alias ifconfig="ip a"
alias pandoc='docker run --rm --volume "`pwd`:/data" --user `id -u`:`id -g` pandoc/latex:2.6'

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
alias todo="awk '/## Top/{flag=1} /## On-deck/{flag=0} flag' $HOME/things/TODO.md | pygmentize -l md"

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
  rm -f /tmp/fun_tokens &
}

function postgres {
  export POSTGRES_VERSION=$1
  export DATABASE_URL="postgres://$USER@localhost:5432/$USER"
  export CONNECTION_STRING=$DATABASE_URL
  docker_ps=`docker ps`
  docker_ls=`docker container ls --all`
  if [[ ! $docker_ps == *"the-postgres-$POSTGRES_VERSION"* ]]; then
    if [[ ! $docker_ls == *"the-postgres-$POSTGRES_VERSION"* ]]; then
      docker run -d -p 5432:5432 --name the-postgres-$POSTGRES_VERSION -e POSTGRES_USER=$USER postgres:$POSTGRES_VERSION
    else
      docker start the-postgres-$POSTGRES_VERSION
    fi
  fi

  docker exec -it the-postgres-$POSTGRES_VERSION psql -U $USER -c "CREATE OR REPLACE DATABASE \"$USER-test\";" > /dev/null
}

function psql {
  docker exec -it the-postgres-$POSTGRES_VERSION psql -U $USER
}

function pg_ {
  docker exec the-postgres-$POSTGRES_VERSION pg_dump -U $USER "$@"
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

eval $(keychain --eval --quiet --quick ~/.ssh/id_rsa)

echo "Finished configuring Ubuntu"
