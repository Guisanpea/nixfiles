{ pkgs, ... }:

let
  dbus-sway-environment = pkgs.writeShellScriptBin "dbus-sway-environment" ''
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
    systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  '';
  dotfiles = ../../.config;
in {

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      base = false;
      gtk = false;
    };
    xwayland = true;
    extraConfig = builtins.readFile "${dotfiles}/sway/config.config";
  };

  programs.rofi = {
    enable = true;

    package = pkgs.rofi-wayland;

    theme = builtins.toString (pkgs.writeText "rofi-theme" ''
      configuration {
        display-drun: "Applications:";
        display-window: "Windows:";
        drun-display-format: "{name}";
        font: "JetBrainsMono Nerd Font Medium 18";
        modi: "window,run,drun,emoji,calc";
      }

      @theme "/dev/null"

      * {
        bg: #11121D;
        bg-alt: #444b6a;

        fg: #FFFFFF;
        fg-alt: #787c99;

        background-color: @bg;
        
        border: 0;
        margin: 0;
        padding: 0;
        spacing: 0;
      }

      window {
        width: 30%;
      }

      element {
        padding: 8 0;
        text-color: @fg-alt;
      }

      element selected {
        text-color: @fg;
      }

      element-text {
        text-color: inherit;
        vertical-align: 0.5;
      }

      element-icon {
        size: 14;
        padding: 0 10 0 0;
      }

      entry {
        background-color: @bg-alt;
        padding: 12;
        text-color: @fg;
      }

      inputbar {
        children: [prompt, entry];
      }

      listview {
        padding: 8 12;
        background-color: @bg;
        columns: 1;
        lines: 8;
      }

      mainbox {
        background-color: @bg;
        children: [inputbar, listview];
      }

      prompt {
        background-color: @bg-alt;
        enabled: true;
        padding: 12 0 0 12;
        text-color: @fg;
      }

    '');
  };
}
