{ config, pkgs, ... }: {
  imports = [
    ./git.nix
    ./php.nix
    ./zsh.nix
  ];
}
