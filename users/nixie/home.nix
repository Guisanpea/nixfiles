{ config, pkgs, ... }:

let
  dotfiles = pkgs.fetchFromGitHub {
    owner = "Guisanpea";
    repo = "dotfiles";
    rev = "391cd5c0b9548da07a86b1d164dfe852fa9ae404";
    sha256 = "0yr5j452q6cidlfcz2k3wx6dcvyp3ay6xissqzx6k9nincp8pnbk";
  };
in
{
  nixpkgs.overlays = [ (import ./overlays/main.nix) ];

  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixie";
  home.homeDirectory = "/home/nixie";

  home.packages = with pkgs; [
    cowsay fortune feh openssl ripgrep
    jetbrains.idea-ultimate emacs
    arandr konsole gnome3.dconf-editor
    lutris-free
    slack tdesktop
  ];

  xdg.configFile."i3".source = "${dotfiles}/i3";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  imports = [
    ./configs/main.nix
    ./packages/main.nix
    ./settings/mime-apps.nix
  ];
}
