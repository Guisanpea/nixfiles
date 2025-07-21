# macOS-specific home configuration
{ lib, config, pkgs, ... }:

let
  dotfiles = ../dotconfig;
in
{
  imports = [
    ../common/home.nix
    ./packages.nix
    ../common/programs/php.nix
  ];

  home = {
    homeDirectory = lib.mkForce "/Users/ssanchez";
  };
  xdg.configFile = {
    "sketchybar".source = "${dotfiles}/sketchybar";
  };
}
