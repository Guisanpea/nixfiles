# Common home configuration shared across all systems
{ config, pkgs, ... }:

let
  dotfiles = ../dotconfig;
in
{
  imports = [
    ./packages.nix
    ./programs/git.nix
  ];

  # Common dotfile configurations
  xdg.configFile = {
    "tmux".source = "${dotfiles}/tmux";
    "doom".source = "${dotfiles}/doom.d";
  };
  
  home.file.".npmrc".source = "${dotfiles}/npmrc";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "20.09";
}
