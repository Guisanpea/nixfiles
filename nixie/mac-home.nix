{ config, pkgs, ... }:

let
  dotfiles = ../dotfiles;
in
{
  home.packages = with pkgs; [
    m-cli
  ]
}
