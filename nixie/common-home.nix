{ config, pkgs, ... }:

let
  dotfiles = ../.config;
  astronvim = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "4ed0efcd922fbc673539f15e13ce0a9e64d6b8b5";
    sha256 = "HeaOselOoCO5pCbNhOZ2NsUgCNkvz7FPYxdKu+Da12k=";
  };
in
{
  nixpkgs.overlays = [
    (import ./overlays/main.nix)
  ];

  imports = [
    ./packages/cli.nix
  ];

  programs.home-manager.enable = true;

  xdg.configFile."tmux".source = "${dotfiles}/tmux";
  xdg.configFile."doom".source = "${dotfiles}/doom.d";
  xdg.configFile."nvim".source = "${astronvim}";
  home.file.".npmrc".source = "${dotfiles}/npmrc";

  home.stateVersion = "20.09";
}
