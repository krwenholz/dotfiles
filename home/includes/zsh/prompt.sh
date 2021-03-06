# Load dependencies.
pmodload 'helper'

function prompt_meine_pwd {
  local pwd="${PWD/#$HOME/~}"

  if [[ "$pwd" == (#m)[/~] ]]; then
    _prompt_meine_pwd="$MATCH"
    unset MATCH
  else
    _prompt_meine_pwd="${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
  fi
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && _prompt_char='±' && return
    _prompt_char='○'
}

function prompt_meine_precmd {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS

  # Format PWD.
  prompt_meine_pwd

  # Set prompt character
  prompt_char
}

function prompt_meine_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  # Load required functions.
  autoload -Uz add-zsh-hook

  # Add hook for calling setup function before command 
  add-zsh-hook precmd prompt_meine_precmd

  # Set editor-info parameters.
  zstyle ':prezto:module:editor:info:completing' format '%B%F{red}...%f%b'
  zstyle ':prezto:module:editor:info:keymap:primary' format ' %B%F{red}❯%F{yellow}❯%F{green}❯%f%b'
  zstyle ':prezto:module:editor:info:keymap:primary:overwrite' format ' %F{red}♺%f'
  zstyle ':prezto:module:editor:info:keymap:alternate' format ' %B%F{green}❮%F{yellow}❮%F{red}❮%f%b'

  # Define prompts.
  PROMPT='${SSH_TTY:+"%F{red}%n%f@%F{yellow}%m%f"}%f%(!. %B%F{red}#%f%b.) %F{green}${_prompt_char}${editor_info[keymap]} '
  RPROMPT='%F{cyan}${_prompt_meine_pwd}   '
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
}

prompt_meine_setup "$@"

