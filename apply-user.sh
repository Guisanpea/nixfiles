pushd ~/.dotfiles
nix build .#homeManagerConfigurations.nixie.activationPackage --impure &&
./result/activate
popd
