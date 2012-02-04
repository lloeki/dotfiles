# Set up the prompt

autoload -Uz promptinit
promptinit

# Set up working dir change event
chpwd() {
    [[ -o interactive ]] || return
    # Bubble information up to the terminal
    case $TERM_PROGRAM in
        Apple_Terminal)
            local SEARCH=' '
            local REPLACE='%20'
            local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
            printf '\e]7;%s\a' "$PWD_URL"
            ;;
        *)
            # NOOP
            ;;
    esac
    case $TERM in
        xterm*)
            print -Pn "\e]0;%n@%m: %~\a"
            ;;
        *)
            # NOOP
            ;;
    esac
}
chpwd # call in right now

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# bind special keys according to readline configuration
eval "$(sed -n 's/#.*//; s/^/bindkey /; s/: / /p' ~/.inputrc)"

# bind some more keys, zsh only
bindkey "\e[Z" reverse-menu-complete    # Shift+Tab

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

# bundler
bundled_commands=(annotate cap capify cucumber foreman guard heroku nanoc rackup rainbows rake rspec ruby shotgun spec spork thin unicorn unicorn_rails irb rails)

_bundler-installed() {
  which bundle > /dev/null 2>&1
}

_within-bundled-project() {
  local check_dir=$PWD
  while [ "$(dirname $check_dir)" != "/" ]; do
    [ -f "$check_dir/Gemfile" ] && return
    check_dir="$(dirname $check_dir)"
  done
  false
}

_run-with-bundler() {
  if _bundler-installed && _within-bundled-project; then
    bundle exec $@
  else
    $@
  fi
}

## Main program
for cmd in $bundled_commands; do
  eval "function bundled_$cmd () { _run-with-bundler $cmd \$@}"
  alias $cmd=bundled_$cmd

  if which _$cmd > /dev/null 2>&1; then
        compdef _$cmd bundled_$cmd=$cmd
  fi
done

# git completion speed boost
__git_files () { 
    _wanted files expl 'local files' _files
}

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
which dircolors >/dev/null && eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' formats "%F{green}%S%f:%F{blue}%b%f:%F{green}%r%f"

precmd() {
    psvar=()
  
    vcs_info
    RPROMPT="%F{green}%~%f"
    [[ -n $vcs_info_msg_0_ ]] && RPROMPT="$vcs_info_msg_0_"
}

PS1="%B%(?..[%?] )%b%n@%m> "
prompt_opts=(cr percent)

source ~/.aliases

