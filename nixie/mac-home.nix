{ lib, config, pkgs, ... }:

{
  imports = [
    ./common-home.nix
    ./configs/common.nix
  ];
  home.packages = with pkgs; [
    m-cli
  ];
  home.sessionPath = [
    "$HOME/.rd/bin"
  ];
   home.homeDirectory = lib.mkForce "/Users/ssanchez";
}
