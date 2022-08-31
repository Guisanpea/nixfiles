#!/bin/sh
pushd ~/.dotfiles
rm ~/.config/mimeapps.list
sudo nixos-rebuild switch --flake .#nixos --impure -L -v
popd
