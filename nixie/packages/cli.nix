{ pkgs, ... }:

with pkgs;
let
  my-php = php81.buildEnv {
    extensions = { enabled, all }: with all; enabled ++ [ dom rdkafka ];
    extraConfig = ''
      # xdebug.mode = debug
      # xdebug.start_with_request = yes
      # xdebug.discover_client_host=1
      # xdebug.client_port = 9000
      # memory_limit = 8G
    '';
  };
in {
  home.packages = with pkgs; [
    # CLI
    aria2
    bat
    broot
    cachix
    cowsay
    delta
    duf
    exa
    fd
    feh
    fortune
    gdu
    git
    git-crypt
    glances
    gnupg
    gping
    htop
    imagemagick
    navi
    neovim
    nix-prefetch-github
    nix-prefetch-git
    neofetch
    pv
    ripgrep
    tldr
    tmux
    tree
    unrar
    unzip
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
    php82Packages.composer
    coursier
    curl
    direnv
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
    prisma-engines
    sbt
    symfony-cli
    terraform
    yarn
  ];
}
