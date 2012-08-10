#!/bin/sh

[ $(pwd) = "$HOME/.dotfiles" ] || ln -sfn "$(pwd)" "$HOME/.dotfiles"

for file in home/*; do
    dotfile="$(basename "$file")"
    case "${dotfile}" in
        Makefile|*.md|LICENSE|setup.sh)
            # NOOP
            ;;
        *)
            # link the file with a leading dot
            echo "linking ${dotfile}"
            ln -sf "$(pwd)/${file}" "$HOME/.${dotfile}"
            ;;
    esac
done

