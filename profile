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

# Ruby Gems
test -d /var/lib/gems/1.8/bin && PATH="$PATH:/var/lib/gems/1.8/bin" RUBYOPT="-rubygems"
export PATH RUBYOPT
# Gems on OSX homebrew
test -d /usr/local/Cellar/ruby/1.9.2-p290/bin && PATH="/usr/local/Cellar/ruby/1.9.2-p290/bin:$PATH"
export PATH

test -d /usr/local/share/python && PATH="/usr/local/share/python:$PATH"


# default editor
EDITOR=vim
VISUAL=vim
export EDITOR VISUAL

# add some color
GREP_OPTIONS='--color=auto'
CLICOLOR=1;
export GREP_OPTIONS CLICOLOR

