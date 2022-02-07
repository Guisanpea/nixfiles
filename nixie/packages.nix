{ pkgs, ... }:

with pkgs;
let
  python-with-my-packages = python3.withPackages(packages: with packages; [
    pip
  ]);
  dotfiles = ~/git/dotfiles;
  my-php = php74.buildEnv {
    extensions = { enabled, all }: with all; enabled ++ [xdebug];
    extraConfig = ''
      xdebug.mode = debug
      xdebug.start_with_request = yes
      xdebug.discover_client_host=1
      xdebug.client_port = 9000
    '';};
    zoom = pkgs.zoom-us.overrideAttrs (old: {
      postFixup = old.postFixup + ''
        wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
      '';});
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
    teams
    swaylock-effects

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
    apacheKafka
    asdf-vm
    kafkacat
    binutils
    chromedriver
    docker-compose
    gradle
    gcc
    gh
    insomnia
    gnumake
    cmake
    helm
    httpie
    idea.idea-community
    nixfmt
    postman
    python-with-my-packages
    awscli
    sbt
    coursier
    metals
    elixir
    erlang
    php74Packages.composer
    my-php
    nodejs-16_x
    vscodium
    dbeaver
    mysql57
    elixir_ls
    terraform
    kubectl
    k9s

    # AUDIO
    pavucontrol
    playerctl

    # DEFAULT
    chromium
    kotatogram-desktop
    discord
    element-desktop
    vlc
    clapper
    spotify
    blueman
    wineWowPackages.stable
    slack
    rmapi
    zoom
    firefox-devedition-bin
    emacsPgtkGcc
    qbittorrent
    libreoffice
    masterpdfeditor

    # GAMES
    multimc

    # WAYLAND
    wdisplays
    waybar
    grim
    slurp
    swappy
  ];
}  
