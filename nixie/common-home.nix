{ config, pkgs, ... }:

let
  dotfiles = ../dotconfig;
in
{
  imports = [ ./packages/cli.nix ];

  xdg.configFile."tmux".source = "${dotfiles}/tmux";
  xdg.configFile."doom".source = "${dotfiles}/doom.d";
  home.file.".npmrc".source = "${dotfiles}/npmrc";

  home.stateVersion = "20.09";
}
