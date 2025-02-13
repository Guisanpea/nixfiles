# macOS-specific home configuration
{ lib, config, pkgs, ... }:

{
  imports = [
    ../common/home.nix
    ./packages.nix
  ];

  programs.php = {
    phpPackage = pkgs.php81;
  };

  home = {
    homeDirectory = lib.mkForce "/Users/ssanchez";
  };
}
