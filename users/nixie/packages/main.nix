{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # MISC
    appimage-run

    # TERMINAL
    aria2
    bat
    broot
    cava
    delta
    duf
    escrotum
    exa
    fd
    feh
    gdu
    git
    git-crypt
    glances
    gnupg
    gotop
    gping
    htop
    imagemagick
    navi
    neofetch
    ripgrep
    tldr
    tree
    unrar
    unzip
    xorg.xev
    zip

    # DEVELOPMENT
    adoptopenjdk-openj9-bin-8
    binutils
    docker-compose
    gradle
    gcc
    gh
    gnumake
    httpie
    idea.idea-ultimate
    nixfmt
    postman
    sbt

    # AUDIO
    pavucontrol

    # DEFAULT
    chromium
    kotatogram-desktop
    discord
    element-desktop
    vlc
    spotify
    blueman
    wineWowPackages.stable
    slack
    rmapi

    # GAMES
    multimc
  ];
}  
