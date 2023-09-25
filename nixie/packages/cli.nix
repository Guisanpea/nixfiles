{ pkgs, ... }:

with pkgs;
let
  my-php = stable.php80.buildEnv {
    extensions = { enabled, all }: with all; enabled ++ [ dom rdkafka xdebug ];
    extraConfig = ''
      xdebug.mode = debug
      xdebug.start_with_request = yes
      xdebug.discover_client_host=1
      xdebug.client_port = 9000
      memory_limit = 8G
    '';
  };
in {
  home.packages = with pkgs; [
    # CLI
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
    binutils
    curl
    docker-compose
    elixir
    elixir_ls
    gh
    httpie
    kubectl
    my-php
    mysql
    nixfmt
    nodePackages.npm
    nodejs
    yarn
  ];
}
