{ config, pkgs, ... }:

let
  dotfiles = ../dotconfig;
in
{
  nixpkgs.overlays = [ (import ./overlays/main.nix) ];

  imports = [ ./packages/cli.nix ];

  # Temp fix for https://github.com/NixOS/nixpkgs/issues/196651
  manual.manpages.enable = false;
  manual.html.enable = false;
  manual.json.enable = false;

  xdg.configFile."tmux".source = "${dotfiles}/tmux";
  xdg.configFile."doom".source = "${dotfiles}/doom.d";
  home.file.".npmrc".source = "${dotfiles}/npmrc";

  home.stateVersion = "20.09";
}
