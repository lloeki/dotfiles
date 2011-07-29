# Set up the prompt

autoload -Uz promptinit
promptinit
prompt walters

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
}
chpwd # call in right now

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# bind special keys according to readline configuration
eval "$(sed -n 's/^/bindkey /; s/: / /p' ~/.inputrc)"

# fix some keys
#bindkey "\e[1~" beginning-of-line       # Home
#bindkey "\e[4~" end-of-line             # End
#bindkey "\e[5~" beginning-of-history    # PageUp
#bindkey "\e[6~" end-of-history          # PageDown
#bindkey "\e[2~" quoted-insert           # Ins
#bindkey "\e[3~" delete-char             # Del
#bindkey "\e[5C" forward-word            #
#bindkey "\eOc" emacs-forward-word       # ^Right
#bindkey "\e[5D" backward-word           #
#bindkey "\eOd" emacs-backward-word      # ^Left
#bindkey "\e\e[C" forward-word           #
#bindkey "\e\e[D" backward-word          #
#bindkey "\e[Z" reverse-menu-complete    # Shift+Tab

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

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

source ~/.aliases

