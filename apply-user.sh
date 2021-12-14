pushd ~/.dotfiles
nix build --print-build-logs .#homeManagerConfigurations.nixie.activationPackage --impure --print-build-logs &&
./result/activate
popd
