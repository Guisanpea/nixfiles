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
  imports = [
    ./packages/linux.nix
    ./configs/linux.nix
    ./common-home.nix
  ];
  home.username = "nixie";
  home.homeDirectory = "/home/nixie";

  xdg.configFile."i3".source = "${dotfiles}/i3";
  xdg.configFile."alacritty".source = "${dotfiles}/alacritty";
  xdg.configFile."sway/config".source = "${dotfiles}/sway/config.config";
  xdg.configFile."waybar".source = "${dotfiles}/waybar";
  xdg.configFile."nvim".source = "${astronvim}";

  home.stateVersion = "20.09";
}
