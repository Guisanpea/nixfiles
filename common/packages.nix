{ pkgs, ... }:

with pkgs;
{
  home.packages = with pkgs; [
    # SYSTEM MONITORING & PERFORMANCE
    bottom
    duf
    gdu
    gping
    htop
    neofetch

    # FILE MANAGEMENT & SEARCH
    bat
    broot
    eza
    fd
    feh
    ripgrep
    tree
    unrar
    unzip
    zip

    # VERSION CONTROL & DEVELOPMENT TOOLS
    cachix
    devenv
    git
    git-crypt
    gh
    lazygit
    nix-prefetch-github
    nix-prefetch-git
    nixpkgs-fmt
    nixfmt-rfc-style
    nil

    # PROGRAMMING LANGUAGES & RUNTIMES
    babashka
    bun
    clojure
    beam26Packages.elixir_1_17
    jdk
    leiningen
    nodePackages.npm
    nodejs
    sbt
    yarn

    # DATABASES & SERVICES
    mysql84
    redis
    docker-compose

    # NETWORK & SECURITY
    curl
    gnupg
    httpie
    kubectl
    kubectx
    wireguard-tools
    symfony-cli

    # TERMINAL UTILITIES
    cowsay
    fortune
    fzf
    jq
    navi
    neovim
    pv
    tldr
    tmux

    # IMAGE PROCESSING
    imagemagick

    # LLM
    aichat
  ];
}
