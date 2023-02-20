{ pkgs, ... }:


with pkgs;
let
  zoom = pkgs.zoom-us.overrideAttrs (old: {
    postFixup = old.postFixup + ''
      wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
    '';
  });

  discord-wayland = pkgs.symlinkJoin {
    name = "discord";
    paths = [ pkgs.discord ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/discord --add-flags "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer,WaylandWindowDecorations --ozone-platform-hint=wayland --ozone-platform=wayland"
    '';
  };

  slack-wayland = pkgs.symlinkJoin {
    name = "slack";
    paths = [ pkgs.slack ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/slack --add-flags "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer,WaylandWindowDecorations --ozone-platform-hint=wayland --ozone-platform=wayland"
    '';
  };

  spotify-wayland = pkgs.symlinkJoin {
    name = "spotify";
    paths = [ pkgs.spotify ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/spotify --add-flags "--enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=wayland --ozone-platform=wayland"
    '';
  };

  vscodium-wayland = pkgs.symlinkJoin {
    name = "vscodium";
    paths = [ pkgs.vscodium ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/codium --add-flags "--enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=wayland --ozone-platform=wayland"
    '';
  };
in {
  home.packages = [
    # AUDIO
    cava
    dmidecode
    pavucontrol
    playerctl

    # CLI
    helm

    # DESKTOP
    blueman
    chromium
    clapper
    discord-wayland
    escrotum
    firefox-wayland
    gnome.file-roller
    gparted
    maestral
    maestral-gui
    obsidian
    qbittorrent
    slack-wayland
    spicetify-cli
    spotify
    vlc
    wineWowPackages.stable
    zathura

    # GAMES
    prismlauncher

    # WAYLAND
    grim
    slurp
    swappy
    waybar
    wdisplays
    wmname

    # DESKTOP DEVELOPMENT
    insomnia
    jetbrains.idea-community
    mongodb-compass
    vscodium-wayland
  ];
}
