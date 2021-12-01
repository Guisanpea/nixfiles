{ pkgs, ... }:

with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    gst-python
    # other python packages you want
  ]; 
  python-with-my-packages = python3.withPackages my-python-packages;
  dotfiles = ~/git/dotfiles;
in {
  programs.mako = {
    extraConfig = (builtins.readFile "${dotfiles}/mako/config");
    enable = true;
  };

  systemd.user.services = {
    mako = {
      Unit = {
        Description = "A lightweight Wayland notification daemon";
        Documentation = "man:mako(1)";
        PartOf = "graphical-session.target";
      };
      Service = {
        Type = "simple";
        Restart = "always";
        ExecStart = "${pkgs.mako}/bin/mako";
      };
      Install = { WantedBy = [ "sway-session.target" ]; };
    };
  };

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
    tmux
    tree
    unrar
    unzip
    xorg.xev
    zip

    # DEVELOPMENT
    jdk
    binutils
    docker-compose
    gradle
    gcc
    gh
    gnumake
    httpie
    idea.idea-community
    nixfmt
    postman
    python-with-my-packages
    sbt

    # AUDIO
    pavucontrol
    playerctl

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

    # WAYLAND
    wdisplays
    waybar
  ];
}  
