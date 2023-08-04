{  ... }:

{
  imports = [
    ./common.nix
    ./mime-apps.nix
    ./sway.nix
  ];

  services.gnome-keyring.enable = true;
}
