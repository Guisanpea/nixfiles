{ config, pkgs, ... }:

let
  dotfiles = ../dotconfig;
in
{
  imports = [
    ./packages/linux.nix 
    ./configs/linux.nix
    ./common-home.nix 
  ];
  home.username = "nixie";
  home.homeDirectory = "/home/nixie";

  xdg.configFile."alacritty".source = "${dotfiles}/alacritty";
  xdg.configFile."i3".source = "${dotfiles}/i3";
  xdg.configFile."waybar".source = "${dotfiles}/waybar";

  home.stateVersion = "20.09";
}
