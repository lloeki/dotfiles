## .profile

# set locale
#export LC_ALL="en_US.UTF-8"

# mono paths
#export MANPATH=/Library/Frameworks/Mono.framework/Versions/Current/share/man:$MANPATH
#export PKG_CONFIG_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig:$PKG_CONFIG_PATH

# user path
PATH=~/.local/bin:$PATH

# python user path
PATH=~/Library/Python/2.7/bin:$PATH

# local path
PATH=/usr/local/bin:/usr/local/sbin:$PATH

# node.js path
NODE_PATH=/usr/local/lib/node
export NODE_PATH

# rbenv
test -d "$HOME/.rbenv/bin" && PATH="$HOME/.rbenv/bin:$PATH"
which rbenv 2>&1 >/dev/null && eval "$(rbenv init -)"

# homebrew python
test -d /usr/local/share/python && PATH="/usr/local/share/python:$PATH"
test -d /usr/local/share/python3 && PATH="/usr/local/share/python3:$PATH"

export PATH

# default editor
EDITOR=vim
VISUAL=vim
export EDITOR VISUAL

# add some color
GREP_OPTIONS='--color=auto'
CLICOLOR=1;
export GREP_OPTIONS CLICOLOR

# ssh keychain, if no agent set
if [ -z "$SSH_AUTH_SOCK" ]; then
    if which keychain 2>&1 >/dev/null; then
        eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
    fi
fi

