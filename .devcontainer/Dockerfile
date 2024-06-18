FROM ghcr.io/krwenholz/nix-devcontainer:main

RUN sudo apt update && sudo apt-get install -y zsh 

VOLUME /nix

RUN nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
RUN nix-channel --update
RUN nix-shell '<home-manager>' -A install
