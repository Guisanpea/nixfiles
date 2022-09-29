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
    discord
    dropbox
    escrotum
    firefox-wayland
    gnome.file-roller
    gparted
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
    insomnia
    jetbrains.idea-community
    jetbrains.phpstorm
    jetbrains.webstorm
    vscodium
  ];
}
