# Linux-specific packages
{ pkgs, ... }:

let
  # VSCode insiders with specific configuration
  # Documentation: https://nixos.wiki/wiki/Visual_Studio_Code
  vscode-insiders = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
    src = (builtins.fetchTarball {
      url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
      sha256 = "09j6h0h4lvsh05h92fg66jc4dpfd5nx2mrbs8srdwxpks5gz5s3d";
    });
    version = "latest";
  });
in 
{
  home.packages = with pkgs; [
    # Audio
    pavucontrol
    playerctl

    # Desktop applications
    blueman
    chromium
    firefox-wayland
    gnome.file-roller
    spotify
    vscode-insiders
    
    # Wayland utilities
    grim
    slurp
    swappy
    waybar
    wdisplays

    # Development
    insomnia
    jetbrains.idea-community
  ];
}
