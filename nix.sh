#!/usr/bin/env bash

set -e
set -u
set -o pipefail

function setup() {
    if grep -e 'experimental-features' /etc/nix/nix.conf; then
        :
    else
        echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf
    fi
}

function save() {
    commit=$(nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version' | perl -n -e '/".*\.([a-z0-9]+)"/ and print "$1\n"')
    channel="https://github.com/NixOS/nixpkgs/archive/${commit}.tar.gz"
    echo "saving: ${channel}"
    echo "${channel}" > nix.channel
}

function install() {
    channel="$(cat nix.channel)"
    echo "using: ${channel}"

    declare -a attrs=()
    while IFS='' read -r line || [[ -n "${line}" ]]; do
        attrs+=("${line}")
    done < nix.attrs

    declare -a args=()
    for attr in "${attrs[@]}"; do
        args+=("-A" "${attr}")
    done

    nix-env -f "${channel}" -i "${args[@]}"
}

function update() {
    nix-channel --update
    save
    install
}

function usage() {
    echo 'usage: nix.sh [setup|save|install|update]' 1>&2
    exit 1
}

case "${1:-}" in
    setup)
        setup
        ;;
    save)
        save
        ;;
    install)
        install
        ;;
    update)
        update
        ;;
    upgrade)
        upgrade
        ;;
    *)
        usage
        ;;
esac
