#!/bin/sh
set -Eeuo pipefail

cd ~/.dotfiles
git pull
rm ~/.config/mimeapps.list
sudo nixos-rebuild switch --flake .#nixos --impure -L -v
git add .
git commit -a
git push
cd -
