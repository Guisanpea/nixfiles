{ config, pkgs, ... }:

{
  imports = [
    ./common-home.nix
    ./configs/common.nix
  ];
  home.packages = with pkgs; [
    m-cli
  ];
}
