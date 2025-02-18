{ pkgs, ... }:

with pkgs;
{
  home.packages = with pkgs; [
    # CLI
    aichat
    babashka
    bat
    bottom
    broot
    cachix
    cloc
    cowsay
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
    yarn

    # PHP
    symfony-cli
  ];
}
