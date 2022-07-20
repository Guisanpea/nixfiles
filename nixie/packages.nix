{ pkgs, ... }:

with pkgs;
let
  python-with-my-packages =
    python3Full.withPackages (packages: with packages; [ pygobject3 pip ]);
  dotfiles = ~/git/dotfiles;
  my-php = php74.buildEnv {
    extensions = { enabled, all }: with all; enabled ++ [ xdebug ];
    extraConfig = ''
      xdebug.mode = debug
      xdebug.start_with_request = yes
      xdebug.discover_client_host=1
      xdebug.client_port = 9000
    '';
  };
  zoom = pkgs.zoom-us.overrideAttrs (old: {
    postFixup = old.postFixup + ''
      wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
    '';
  });
in {
  programs.mako = {
    enable = true;
    extraConfig = (builtins.readFile "${dotfiles}/mako/config");
  };

  home.packages = with pkgs; [
    # MISC
    appimage-run
    teams

    # TERMINAL
    aria2
    bat
    broot
    cava
    delta
    dig
    dmidecode
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
    ncdu
    neofetch
    ripgrep
    tldr
    tmux
    tree
    unrar
    unzip
    xorg.xev
    wireguard-tools
    zip

    # DEVELOPMENT
    apacheKafka
    argocd
    asdf-vm
    awscli
    binutils
    chromedriver
    cmake
    coursier
    dbeaver
    docker-compose
    elixir
    elixir_ls
    emacsPgtkNativeComp
    erlang
    gcc
    gh
    gnumake
    gparted
    gradle
    helm
    httpie
    insomnia
    jdk
    jetbrains.idea-community
    jetbrains.phpstorm
    k9s
    kafkacat
    kubectl
    metals
    my-php
    mysql57
    nixfmt
    nodejs-16_x
    php74Packages.composer
    postman
    python-with-my-packages
    sbt
    symfony-cli
    terraform
    vscodium

    # AUDIO
    pavucontrol
    playerctl

    # DESKTOP
    blueman
    chromium
    clapper
    discord
    dropbox
    firefox-devedition-bin
    firefox-wayland
    libreoffice
    maestral
    maestral-gui
    qbittorrent
    rmapi
    slack
    spicetify-cli
    spotify
    vlc
    wineWowPackages.stable
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
  ];
}
