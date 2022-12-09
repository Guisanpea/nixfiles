{ config, pkgs, ... }:

let
  dotfiles = ../.config;
  astronvim = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "294e99657f52bea475d5f468645a761cfa6afe58";
    sha256 = "1l521lr2nf16rb1q7m9nmsggnrj0i34vlfplrw5xv2nxxjspg1ls";
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
