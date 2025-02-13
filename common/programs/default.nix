{ config, pkgs, ... }: [
  ./git.nix
  (import ./php.nix { inherit pkgs; phpVersion = config.programs.php.phpPackage or pkgs.php81; })
  ./zsh.nix
]
