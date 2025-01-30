# Common packages that should be available on all systems
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Development tools
    git
    git-crypt
    gnupg
    neovim
    tmux

    # System utilities
    bat
    bottom
    direnv
    eza
    fd
    fzf
    htop
    jq
    ripgrep
    tree
    unzip
    zip

    # Languages and Development
    nodejs
    yarn
    nixfmt-rfc-style
  ];
}
