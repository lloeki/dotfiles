#!/bin/sh

for dotfile in *; do
    if [ "${dotfile}" != "scripts" ]; then
        echo "linking ${dotfile}"
        ln -sf "$(pwd)/${dotfile}" "$HOME/.${dotfile}"
    fi
done

