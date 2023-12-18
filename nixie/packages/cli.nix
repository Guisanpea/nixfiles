{ pkgs, ... }:

with pkgs;
let
  my-php = php81.buildEnv {
    extensions = ({ enabled, all }: enabled ++ [ all.dom all.rdkafka all.xdebug ]);
    extraConfig = ''
      xdebug.client_host=localhost
      xdebug.client_port="9003"
      memory_limit = 8G
      max_execution_time = 600
      xdebug.mode = debug
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
    curl
    docker-compose
    gh
    httpie
    kubectl
    my-php
    mysql
    nixfmt
    nodePackages.npm
    nodejs
    python3
    symfony-cli
    yarn
  ];
}
