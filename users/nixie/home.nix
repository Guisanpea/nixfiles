{ config, pkgs, ... }:

let
  dotfiles = ~/git/dotfiles;
  # pkgs.fetchFromGitHub {
  #   owner = "Guisanpea";
  #   repo = "dotfiles";
  #   rev = "d6f275c1802141dc91f687b5a7fa2289948733b2";
  #   sha256 = "11wz3iikimwxljhjc8m3cyfvnn2d8g3vrzwns4wih2l25bnsbwvy";
  # };
in
{
  nixpkgs.overlays = [
    (import ./overlays/main.nix)
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  programs.home-manager.enable = true;


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixie";
  home.homeDirectory = "/home/nixie";

  home.packages = with pkgs; [
    cowsay fortune feh openssl ripgrep
    jetbrains.idea-ultimate 
    arandr konsole gnome3.dconf-editor
    lutris-free
    slack tdesktop
    doom-emacs
  ];

  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';

  xdg.configFile."i3".source = "${dotfiles}/i3";
  xdg.configFile."tmux".source = "${dotfiles}/tmux";
  xdg.configFile."alacritty".source = "${dotfiles}/alacritty";
  xdg.configFile."sway/config".source = "${dotfiles}/sway/config.config";
  xdg.configFile."waybar".source = "${dotfiles}/waybar";
  home.file.".Xresources".source = "${dotfiles}/.Xresources";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  imports = [
    ./configs/main.nix
    ./packages/main.nix
  ];
}
