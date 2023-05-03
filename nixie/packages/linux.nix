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
    rstudio
    slack
    spicetify-cli
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
