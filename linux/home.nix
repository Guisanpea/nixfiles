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
    "alacritty".source = "${dotfiles}/alacritty";
    "i3".source = "${dotfiles}/i3";
    "waybar".source = "${dotfiles}/waybar";
    "sway/config".source = "${dotfiles}/sway/config.config";
    "hypr".source = "${dotfiles}/hypr";
  };

  programs.home-manager.enable = true;

  # Default application associations (MIME types)
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # Web
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];

      # PDF and similar
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "application/x-pdf" = [ "org.pwmt.zathura.desktop" ];

      # Text/code files (VSCode as default editor for desktop use)
      "text/plain" = [ "code.desktop" ];
      "text/x-python" = [ "code.desktop" ];
      "text/x-shellscript" = [ "code.desktop" ];
      "text/x-csrc" = [ "code.desktop" ];
      "text/x-c++src" = [ "code.desktop" ];
      "application/json" = [ "code.desktop" ];
      "application/x-yaml" = [ "code.desktop" ];
      "application/x-shellscript" = [ "code.desktop" ];
      "application/x-desktop" = [ "code.desktop" ];

      # Images (sane default: feh)
      "image/png" = [ "feh.desktop" ];
      "image/jpeg" = [ "feh.desktop" ];
      "image/svg+xml" = [ "feh.desktop" ];

      # Video (sane default: mpv)
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];

      # Audio (sane default: mpv)
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/x-wav" = [ "mpv.desktop" ];
    };
  };
}
