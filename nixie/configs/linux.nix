{  ... }:

{
  imports = [
    ./common.nix
    ./mime-apps.nix
  ];

  services.gnome-keyring.enable = true;
}
