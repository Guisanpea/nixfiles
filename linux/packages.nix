{ pkgs, ... }:


with pkgs;
let vscode-insiders =
    (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
      src = (builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
        sha256 = "09j6h0h4lvsh05h92fg66jc4dpfd5nx2mrbs8srdwxpks5gz5s3d";
      });
      version = "latest";
    });
in {
  home.packages = [
    # AUDIO
    pavucontrol
    playerctl

    # CLI
    bottom
    helm
    bind

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
    vscode-insiders
    teamviewer

    zathura

    # GAMES
    jdk17
    lutris
    prismlauncher
    wine

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
