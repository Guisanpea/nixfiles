{ config, lib, pkgs, ... }:

{
  imports = [
    ./rofi.nix
    ./common.nix
    ./mime-apps.nix
  ];
}
