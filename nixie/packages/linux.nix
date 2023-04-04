{ pkgs, ... }:


with pkgs;
let
  zoom = pkgs.zoom-us.overrideAttrs (old: {
    postFixup = old.postFixup + ''
      wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
    '';
  });
in
{
  home.packages = [
    # AUDIO
    cava
    dmidecode
    pavucontrol
    playerctl

    # CLI
    btop
    helm

    # DESKTOP
    blueman
    chromium
    clapper
    discord
    escrotum
    firefox-wayland
    gnome.file-roller
    gparted
    maestral
    maestral-gui
    obsidian
    qbittorrent
    rstudio
    slack
    spicetify-cli
    spotify
    vlc
    vscodium
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
  ];
}
