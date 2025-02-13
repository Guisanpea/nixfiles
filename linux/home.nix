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

  programs.php = {
    phpPackage = pkgs.php81;
  };

  home = {
    username = "archie";
    homeDirectory = "/home/archie";
  };

  # Linux-specific dotfiles
  xdg.configFile = {
    "alacritty".source = "${dotfiles}/alacritty";
    "i3".source = "${dotfiles}/i3";
    "waybar".source = "${dotfiles}/waybar";
  };
}
