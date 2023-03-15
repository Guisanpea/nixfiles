{ config, pkgs, ... }:

let
  dotfiles = ../.config;
  vim = pkgs.fetchFromGitHub {
    owner = "LazyVim";
    repo = "starter";
    rev = "9ad6acdff121ad344cebeb640b48e6ed4d5a8f58";
    hash = "sha256-F/jipxu8+I0uIJBdTc8PdTFXDwTX7dYYudGessV9xh4=";
  };
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
  xdg.configFile."nvim".source = "${vim}";
  home.file.".npmrc".source = "${dotfiles}/npmrc";

  home.stateVersion = "20.09";
}
