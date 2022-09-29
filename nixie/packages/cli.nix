{ pkgs, ... }:

with pkgs;
let
  my-php = p2205.php74.buildEnv {
    extensions = { enabled, all }: with all; enabled ++ [ xdebug ];
    extraConfig = ''
      # xdebug.mode = debug
      # xdebug.start_with_request = yes
      # xdebug.discover_client_host=1
      # xdebug.client_port = 9000
    '';
  };
in {
  home.packages = with pkgs; [
    # CLI
    aria2           #
    bat             #
    broot           #
    cachix          #
    cowsay          #
    delta           #
    duf             #
    exa             #
    fd              #
    feh             #
    fortune         #
    gdu             #
    git             #
    git-crypt       #
    glances         #
    gnupg           #
    gotop           #
    gping           #
    htop            #
    imagemagick     #
    navi            #
    ncdu            #
    neofetch        #
    pv              #
    ripgrep         #
    tldr            #
    tmux            #
    tree            #
    unrar           #
    unzip           #
    wireguard-tools #
    zip             #

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
    erlang
    gh
    gnumake
    gradle
    httpie
    jdk
    k9s
    kafkacat
    kubectl
    metals
    my-php
    mysql57
    nixfmt
    p2205.php74Packages.composer
    sbt
    symfony-cli
    terraform
    yarn
  ];
}
