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
    username = "archie";
    homeDirectory = "/home/archie";
    file.".Xmodmap".text = ''
      clear Lock
      keysym Caps_Lock = Escape
      keysym Escape = Caps_Lock
      add Lock = Caps_Lock
    '';
  };

  # Linux-specific dotfiles
  xdg.configFile = {
    "alacritty".source = "${dotfiles}/alacritty";
    "i3".source = "${dotfiles}/i3";
    "waybar".source = "${dotfiles}/waybar";
  };
}
