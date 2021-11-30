#!/bin/sh

for file in home/*; do
    dotfile="$(basename "$file")"
    case "${dotfile}" in
        Makefile|*.md|LICENSE|setup.sh)
            : # NOOP
            ;;
        *)
            if [ -d "${dotfile}" ]; then
                :
            else
              # link the file with a leading dot
              echo "linking ${dotfile}"
              ln -sf "${PWD}/${file}" "$HOME/.${dotfile}"
            fi
            ;;
    esac
done

