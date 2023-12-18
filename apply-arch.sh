#!/bin/bash

cd ~/.dotfiles
nix build ~/.dotfiles#homeConfigurations.archie.activationPackage --impure
~/.dotfiles/result/activate
cd -
