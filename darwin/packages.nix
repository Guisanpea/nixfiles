{ pkgs, ... }:

{
  home.packages = (import ../common/packages.nix { inherit pkgs; }).home.packages ++ (with pkgs; [
    m-cli
  ]);
}
