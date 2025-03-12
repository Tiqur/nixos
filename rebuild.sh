#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {desktop|laptop|server}"
    exit 1
fi

case "$1" in
    desktop|laptop|server)
        sudo nixos-rebuild switch --flake ./#"$1"
        ;;
    *)
        echo "Invalid argument. Use 'desktop', 'laptop', or 'server'."
        exit 1
        ;;
esac
