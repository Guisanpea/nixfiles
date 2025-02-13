{ pkgs, ... }:


with pkgs;
{
  home.packages = [
    # AUDIO
    pavucontrol
    playerctl

    # CLI
    bottom
    helm
    bind
  ];
}
