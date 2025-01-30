# Linux-specific home configuration
{ config, pkgs, ... }:

let
  dotfiles = ../dotconfig;
in
{
  imports = [
    ../common/home.nix
    ./packages.nix
  ];

  home = {
    username = "nixie";
    homeDirectory = "/home/nixie";
  };

  # Linux-specific dotfiles
  xdg.configFile = {
    "alacritty".source = "${dotfiles}/alacritty";
    "i3".source = "${dotfiles}/i3";
    "waybar".source = "${dotfiles}/waybar";
  };
}
