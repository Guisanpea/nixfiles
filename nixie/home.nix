{ config, pkgs, ... }:

let
  dotfiles = ~/git/dotfiles;
  # dotfiles = pkgs.fetchFromGitHub {
  #   owner = "Guisanpea";
  #   repo = "dotfiles";
  #   rev = "771494b73b439994f9c4a213d04deb929a8656d";
  #   sha256 = "6DC7I2OIYsslFb2qhp3dq9HjrFidezzpEwp3zQtVGD0=";
  # };
in
{
  nixpkgs.overlays = [
    (import ./overlays/main.nix)
  ];

  imports = [
    ./configs/main.nix
    ./packages.nix
  ];


  home.username = "nixie";
  home.homeDirectory = "/home/nixie";
  home.sessionPath = ["$HOME/git/phpactor/bin" "$HOME/git/elixir-ls/release"];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    cowsay fortune feh openssl ripgrep
    jetbrains.idea-ultimate 
    arandr konsole gnome3.dconf-editor
    lutris-free
    slack tdesktop
  ];

  xdg.configFile."i3".source = "${dotfiles}/i3";
  xdg.configFile."tmux".source = "${dotfiles}/tmux";
  xdg.configFile."alacritty".source = "${dotfiles}/alacritty";
  xdg.configFile."sway/config".source = "${dotfiles}/sway/config.config";
  xdg.configFile."waybar".source = "${dotfiles}/waybar";
  xdg.configFile."doom".source = "${dotfiles}/doom.d";
  home.file.".Xresources".source = "${dotfiles}/.Xresources";

  home.stateVersion = "20.09";
}
