{ config, pkgs, ... }:

let
  dotfiles = /home/nixie/git/dotfiles;
  astronvim = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "ba775276324b75e4f703cd63fea3cfe7726514de";
    sha256 = "tMHi5P/EmYoRYp6kdRGxSWJ3o1EPxVk+V6OkRc5ly0Y=";
  };
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
  xdg.configFile."nvim".source = "${astronvim}";
  home.file.".Xresources".source = "${dotfiles}/.Xresources";
  home.file.".npmrc".source = "${dotfiles}/npmrc";

  home.stateVersion = "20.09";
}
