{ pkgs, ... }:

with pkgs;
let
  my-php = php.buildEnv {
    extensions = ({ enabled, all }: enabled ++ [ all.ssh2 all.tidy all.dom all.rdkafka all.xdebug ]);
    extraConfig = ''
      memory_limit = 8G
      max_execution_time = 600
      [xdebug]
      xdebug.mode = debug
      xdebug.start_with_request = trigger
      xdebug.discover_client_host = 1
      xdebug.client_host=127.0.0.1
      xdebug.log=/var/www/var/log/xdebug.log
      xdebug.log_level=0
    '';
  };
in
{
  home.packages = with pkgs; [
    # CLI
    babashka
    bat
    bottom
    broot
    cachix
    cloc
    cowsay
    devenv
    direnv
    duf
    eza
    fd
    feh
    fortune
    fzf
    gdu
    git
    git-crypt
    gnupg
    gping
    htop
    imagemagick
    jq
    lazygit
    leiningen
    navi
    neovim
    nil
    nix-prefetch-github
    nix-prefetch-git
    nixpkgs-fmt
    neofetch
    or-tools
    pv
    redis
    ripgrep
    sbt
    tldr
    tmux
    tree
    unrar
    unzip
    wireguard-tools
    zip

    # DEVELOPMENT
    bun
    clojure
    curl
    docker-compose
    beam.packages.erlang_27.elixir_1_16
    gh
    httpie
    jdk
    kubectl
    kubectx
    leiningen
    mysql
    nixfmt-rfc-style
    nodePackages.npm
    nodejs
    python3
    yarn

    # PHP
    my-php
    my-php.packages.composer
    symfony-cli
  ];
}
