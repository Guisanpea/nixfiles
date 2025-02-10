{ pkgs, ... }:

with pkgs;
let
  my-php = php81.buildEnv {
    extensions = ({ enabled, all }: enabled ++ [ all.ssh2 all.tidy all.dom all.rdkafka all.xdebug ]);
    extraConfig = ''
      memory_limit = 8G
      max_execution_time = 600
      [xdebug]
      xdebug.mode = debug
      xdebug.profiler_output_name = cachegrind.out.%p
      xdebug.output_dir=/Users/ssanchez/work/ouiteamserver_interne
      xdebug.start_with_request = trigger
      xdebug.discover_client_host = 1
      xdebug.client_host=127.0.0.1
      xdebug.log=/tmp/xdebug.log
      xdebug.log_level=3
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
    gh
    httpie
    jdk
    kubectl
    kubectx
    leiningen
    mariadb
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
