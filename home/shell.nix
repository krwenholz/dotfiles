{ config, pkgs, ... }:

{
  environment.pathsToLink = [ "/share/zsh" ];
  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
    TODO = "$HOME/things/TODO.md";
    DONE_SELF = "$HOME/things/DONE_SELF.md";
    DONE_WORK = "$HOME/things/DONE_WORK.md";
  };

  home-manager.users.kyle = { pkgs, ...}: {
    home.file = {
      # TODO(kyle): not working with theme settings yet
      ".zprezto-contrib/modules/prompt/functions/prompt_meine_setup".text = builtins.readFile includes/zsh/prompt.sh;
    };

    programs.tmux = {
      enable = true;
      keyMode = "vi";
        #bind-key -T copy-mode y send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard >/dev/null'
      extraConfig = ''
        bind P paste-buffer
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection
        bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
        set-option -g history-limit 100000
        set -sg escape-time 10
        bind c   new-window   -c    "#{pane_current_path}"
        bind '"' split-window -c    "#{pane_current_path}"
        bind %   split-window -h -c "#{pane_current_path}"
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
      };
      history = {
        save =  100000;
        size =  100000;
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
          "directory"
          "spectrum"
          "utility"
          "completion"
          "syntax-highlighting"
          "git"
          "prompt"
        ];
        prompt.theme = "sorin";
      };
      envExtra = ''
        function git-update {
          current_branch=`git rev-parse --abbrev-ref HEAD`
          echo "Updating branch $current_branch"
          git checkout master
          git fetch origin master
          git rebase origin/master
          git checkout $current_branch
          git rebase master
        }
        function ipython {
          if [[ -f bin/ipython ]]; then
            bin/ipython
          else
            python3 -m IPython
          fi
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
      '';
      initExtra = ''
        bindkey '^F' fzf-file-widget
      '';
      loginExtra = "cowsay -f dragon \"Hey there! ツ\"";
    };
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden --follow --glob '!.(git|hg|svg)/*'";
      defaultOptions = [ "--preview-window 'right:50%:wrap'" "--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -100'" ];
    };
  };
}