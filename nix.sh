#!/usr/bin/env sh

cd ~/.dotfiles
nix build .#darwinConfigurations.ssanchez.system --impure -L -v &&
  ./result/sw/bin/darwin-rebuild switch --flake .#ssanchez --impure -L -v
cd -
