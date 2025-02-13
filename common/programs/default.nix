{ config, pkgs, ... }: {
  imports = [
    ./git.nix
    (import ./php.nix { inherit pkgs; phpVersion = config.programs.php.phpPackage or pkgs.php81; })
    (import ./zsh.nix { inherit config pkgs lib; })
  ];
}
