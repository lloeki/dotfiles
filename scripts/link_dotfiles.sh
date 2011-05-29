#!/bin/sh

for dotfile in *; do
    if [ "${dotfile}" != "scripts" ]; then
        echo ln -sf "$(pwd)/${dotfile}" "~/.${dotfile}"
    fi
done

