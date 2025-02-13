{ config, ... }: [
  ./git.nix
  (import ./php.nix { phpVersion = config.programs.php.phpPackage or pkgs.php81; })
  ./zsh.nix
]
