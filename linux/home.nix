# Linux-specific home configuration
{ config, pkgs, ... }:

let
  dotfiles = ../dotconfig;
in
{
  imports = [
    ../common/home.nix
    ../common/packages.nix
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

    sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };
  };

  # Linux-specific dotfiles
  xdg.configFile = {
    "hyprpanel".source = "${dotfiles}/hyprpanel";
    "alacritty".source = "${dotfiles}/alacritty";
    "code-flags.conf".source = "${dotfiles}/code-flags.conf";
    "sway/config".source = "${dotfiles}/sway/config.config";
    "hypr".source = "${dotfiles}/hypr";
  };

  programs.home-manager.enable = true;

  # Default application associations (MIME types)
  xdg.mimeApps = import ./mimeapps.nix;
}
