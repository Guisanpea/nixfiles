{ pkgs, ... }:


with pkgs;
let
  zoom = pkgs.zoom-us.overrideAttrs (old: {
    postFixup = old.postFixup + ''
      wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
    '';
  });
in {
  home.packages = [
    # AUDIO
    pavucontrol
    playerctl

    # DESKTOP
    blueman
    chromium
    clapper
    discord
    dropbox
    firefox-wayland
    gnome.file-roller
    maestral
    maestral-gui
    qbittorrent
    slack
    spicetify-cli
    spotify
    vlc
    wineWowPackages.stable
    zathura
    zoom

    # GAMES
    polymc

    # WAYLAND
    grim
    slurp
    swappy
    waybar
    wdisplays
    wmname

    # DESKTOP DEVELOPMENT
    emacsPgtkNativeComp
    jetbrains.idea-community
    jetbrains.phpstorm
    jetbrains.webstorm
    vscodium
  ];
}
