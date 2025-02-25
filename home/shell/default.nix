{ lib, pkgs, ... }:

{
  home.file = {
    ".config/starship.toml".text = builtins.readFile ./starship.toml;
    ".config/jj/config.toml".text = builtins.readFile ./jj.toml;
    ".config/pgcli/config".text = builtins.readFile ./pgcli.toml;
    ".ipython/profile_default/ipython_config.py".text = builtins.readFile ./ipython_config.py;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shell = "/bin/zsh";
    #bind-key -T copy-mode y send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard >/dev/null'
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      new-session
      bind P paste-buffer
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      set -sg escape-time 10
      bind c   new-window   -c    "#{pane_current_path}"
      bind '"' split-window -c    "#{pane_current_path}"
      bind %   split-window -h -c "#{pane_current_path}"
      tmux_conf_copy_to_os_clipboard=true
      set-option -g history-limit 1000000
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      pingtest = "ping -c 3 google.com";
      gist = "git status";
      gamit = "git commit --amend --no-edit";
      gummy = "git add .; git commit -m \"WIP `date --iso-8601=minutes`\"";
      my-ip = "ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print \$2}' | cut -f1  -d'/'";
      todos = "rg --hidden --follow --glob '!.(git|hg|svn)' -e 'TODO\(kyle\)'";
      gh = "cd `git rev-parse --show-toplevel`";
      shrug = "echo '¯\\_(ツ)_/¯'";
      flip_table = "echo '(╯°□°）╯︵ ┻━┻'";
      # TODO(kyle): might be able to improve these commands using `tmux set-buffer/save-buffer`
      pbcopy = "xsel --clipboard --input";
      pbpaste = "xsel --clipboard --output";
      image-viewer = "eog";
      grep = "grep --color";
      ls = "lsd";
      netstat = "tldr ss";
      iwconfig = "tldr iw";
      ifconfig = "ip a";
      pandoc = "docker run --rm --volume \"`pwd`:/data\" --user `id -u`:`id -g` pandoc/latex:2.6";
      simple_server = "nix-shell -p python3 --command 'python3 -m http.server 8000'";
      ipython = "nix-shell -p pkgs.python38Packages.ipython --command ipython";
      performance_test = "/usr/bin/time -f '%Uu %Ss %er %MkB %C' \"$@\"";
      pandoc_readmes = "nix-shell --packages \"[ pandoc texliveSmall mermaid-filter ]\" --command 'pandoc README.md -o README.pdf --toc -V papersize:a4 --highlight-style pygments -N -V geometry:\"top=2cm, bottom=1.5cm, left=2cm, right=2cm\"'";
    };
    history = {
      save = 100000;
      size = 100000;
      ignoreDups = true;
    };
    prezto = {
      enable = true;
      editor.keymap = "vi";
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "history-substring-search"
        "spectrum"
        "utility"
        "completion"
        "syntax-highlighting"
        "git"
      ];
      prompt.theme = "off";
    };
    envExtra = ''
      function git-update {
        current_branch=`git rev-parse --abbrev-ref HEAD`
        echo "Updating branch $current_branch"
        git checkout main
        git fetch origin main
        git rebase origin/main
        git checkout $current_branch
        git rebase main
      }

      function fig() {
        git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always %') << 'FZF-EOF'
                {}
        FZF-EOF"
      }

      function things_down {
        (cd $THINGS; git-update)
      }

      function things_up {
        (cd $THINGS; git add . && git commit -m "Things update `date`"; git push origin main)
      }
      alias tedit="things_down && vim $THINGS/TODO.md $THINGS/DONE_SELF.md $THINGS/DONE_WORK.md && things_up &"
      alias todo="nix-shell -p pkgs.python38Packages.pygments --command \"awk '/## Top/{flag=1} /## Conversations/{flag=0} flag' /home/kyle/dinge/TODO.md | pygmentize -l md\""

      function tokens {
        echo Pulling
        things_down
        echo Decrypting
        gpg --decrypt --output /tmp/fun_tokens $THINGS/fun_tokens
        vim /tmp/fun_tokens
        echo Encrypting
        gpg --symmetric --output $THINGS/fun_tokens /tmp/fun_tokens
        echo Uploading
        things_up &
        rm -f /tmp/fun_tokens &
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

      function geb {
        git checkout -b kyle/$1
      }
      PATH=$PATH:$HOME/includes/bin

      bindkey '^F' fzf-file-widget
      RPROMPT=""
      if [ -v AWS_CREDENTIALS ]; then
        mkdir -p ~/.aws
        echo $AWS_CREDENTIALS > ~/.aws/credentials
      fi
          
      mkdir -p ~/.ssh
      echo $SSH_KEY > ~/.ssh/kyle
      echo $SSH_KEY_PUB > ~/.ssh/kyle.pub
      chmod 644 ~/.ssh/kyle.pub && \
      chmod 600 ~/.ssh/kyle

      # Sometimes, it's just easier to have asdf around (e.g. installing elixir in docker on mac in a devcontainer on a turtle)
      if test -d "$HOME/.asdf"; then
        echo "Sourcing asdf, since it's here"
        . "$HOME/.asdf/asdf.sh"
      fi

      # needed to be able to open files in VS Code's editor from the command line, especially tmux
      # https://github.com/microsoft/vscode-remote-release/issues/6362#issuecomment-1047851356
      export VSCODE_IPC_HOOK_CLI="$( \ls 2>/dev/null -1 -t /tmp/vscode-ipc-*.sock | head -n 1 )"

      # Company things
      export FAY_USER=krwenholz
      if [ -e "$HOME/corporate_things.sh" ]; then
        source "$HOME/corporate_things.sh"
      fi

      echo "
             ^...^
            / o,o \\
            |):::(|
          ====w=w===
          "
    '';
    initExtra = ''
      eval "$(starship init zsh)"
      if command -v direnv &> /dev/null; then
        eval "$(direnv hook zsh)"
      fi

      # Dynamic jj completions
      autoload -U compinit
      compinit
      source <(COMPLETE=zsh jj)
    '';
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden --follow --glob '!.(git|hg|svg)/*'";
    defaultOptions = [ "--preview-window 'right:50%:wrap'" "--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -100'" ];
  };
}
