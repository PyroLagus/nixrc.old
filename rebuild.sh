#!/usr/bin/env bash

SRC=$HOME/code/nixrc
sudo rsync --filter="protect /hardware-configuration.nix" \
           --filter="protect /hostname" \
           --filter="protect /nixpkgs" \
           --filter="protect /private" \
           --filter="protect /release" \
           --filter="exclude,s *.gitignore" \
           --filter="exclude,s *.gitmodules" \
           --filter="exclude,s *.git" \
           --filter="exclude .*.swp" \
           --filter="exclude Session.vim" \
           --filter="exclude *~" \
           --filter="exclude \#*\#" \
           --delete --recursive --perms \
           $SRC/ /etc/nixos/
if [ $# -eq 0 ]; then
  operation='switch'
else
  operation=$1
fi
sudo NIX_CURL_FLAGS='--retry=1000' nixos-rebuild --keep-failed $operation
