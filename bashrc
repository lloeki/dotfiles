## bashrc

# set a nice prompt
source ~/.bash_prompt

# ignore repeated, space-started, and casual commands
export HISTIGNORE="&:[ ]*:l[sl]:[bf]g:exit"

# enable multiline single command
shopt -s cmdhist
# enable appending to histfile
shopt -s histappend
shopt -s cdspell

# turn off bells
set bell-style none

source ~/.aliases

