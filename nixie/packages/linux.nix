{ pkgs, ... }:


with pkgs;
{
  home.packages = [
    # AUDIO
    pavucontrol
    playerctl

    # CLI
    bottom
    helm

    # DESKTOP
    blueman
    chromium
    clapper
    discord
    firefox-wayland
    gnome.file-roller
    gparted
    qbittorrent
    spotify
    vlc
    vscodium
    zathura

    # GAMES
    jdk17
    stable.prismlauncher

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
  ];
}
