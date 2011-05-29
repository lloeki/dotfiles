## bash_profile

# handle .profile too
. .profile


# homebrew bash autocompletion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# execute bashrc
[ -n "$BASH" ] && . ~/.bashrc

