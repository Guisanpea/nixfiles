{ pkgs, ... }:

{
  home.packages = (import ../common/packages.nix { inherit pkgs; }).home.packages ++ [
    # AUDIO
    pavucontrol
    playerctl

    # CLI
    bottom
    helm
    bind
  ];
}
