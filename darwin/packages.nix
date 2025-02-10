# macOS-specific packages
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    m-cli
  ];
}
