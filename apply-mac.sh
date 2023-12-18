#!/usr/bin/env sh
set -Eeuo pipefail

cd ~/.dotfiles
git pull
nix build .#darwinConfigurations.ssanchez.system --impure -L -v &&
  ./result/sw/bin/darwin-rebuild switch --flake .#ssanchez --impure -L -v &&
  git add . &&
  git commit -a &&
  git push 
cd -
