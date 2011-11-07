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
eval "$(rbenv init -)"

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

