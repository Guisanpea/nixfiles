{ pkgs, ... }:

with pkgs;
let
  my-php = php81.buildEnv {
    extensions = { enabled, all }: with all; enabled ++ [ dom xdebug rdkafka ];
    extraConfig = ''
      # xdebug.mode = debug
      # xdebug.start_with_request = yes
      # xdebug.discover_client_host=1
      # xdebug.client_port = 9000
      memory_limit = 1G
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
    gping           #
    htop            #
    imagemagick     #
    navi            #
    neovim
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
    kubectx
    kubelogin
    metals
    my-php
    mysql
    nixfmt
    nodePackages.npm
    nodejs
    (p2205.php74Packages.composer.override {
        php = my-php;
    })
    sbt
    symfony-cli
    terraform
    yarn
  ];
}
