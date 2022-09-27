{ config, pkgs, ... }:

let
  dotfiles = ../dotfiles;
in
{
  imports = [
    ./packages/cli.nix
    ./packages/linux.nix
    ./common-home.nix
  ];
  home.username = "nixie";
  home.homeDirectory = "/home/nixie";

  xdg.configFile."i3".source = "${dotfiles}/i3";
  xdg.configFile."alacritty".source = "${dotfiles}/alacritty";
  xdg.configFile."sway/config".source = "${dotfiles}/sway/config.config";
  xdg.configFile."waybar".source = "${dotfiles}/waybar";

  home.stateVersion = "20.09";
}
