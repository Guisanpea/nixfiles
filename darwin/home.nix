# macOS-specific home configuration
{ lib, config, pkgs, ... }:

{
  imports = [
    ../common/home.nix
    ./packages.nix
    ../common/programs/php.nix
  ];

  home = {
    homeDirectory = lib.mkForce "/Users/ssanchez";
  };
}
