{ pkgs, ... }:

with pkgs;
let
  my-php = php81.buildEnv {
    extensions = ({ enabled, all }: enabled ++ [ all.dom all.rdkafka all.xdebug ]);
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
    bat
    bottom
    broot
    cachix
    cowsay
    delta
    duf
    exa
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
    lazygit
    navi
    neovim
    nil
    nix-prefetch-github
    nix-prefetch-git
    nixpkgs-fmt
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
    clojure
    curl
    docker-compose
    elixir
    gh
    httpie
    jdk
    kubectl
    mysql
    nixfmt
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
