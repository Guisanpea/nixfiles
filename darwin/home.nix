# macOS-specific home configuration
{ lib, config, pkgs, ... }:

{
  imports = [
    ../common/home.nix
    ./packages.nix
  ];

  home = {
    homeDirectory = lib.mkForce "/Users/ssanchez";
  };
}
