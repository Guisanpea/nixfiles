#!/bin/sh
set -Eeuo pipefail

cd ~/.dotfiles
#git pull
rm ~/.config/mimeapps.list || :
sudo -E nixos-rebuild switch --flake .#nixos --impure -L -v --show-trace
git add .
git commit -a
git push
cd -
