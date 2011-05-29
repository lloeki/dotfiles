#!/bin/sh

for dotfile in *; do
    case "${dotfile}" in
        scripts|Makefile)
            # NOOP
            ;;
        *)
            # link the file with a leading dot
            echo "linking ${dotfile}"
            ln -sf "$(pwd)/${dotfile}" "$HOME/.${dotfile}"
            ;;
    esac
done

