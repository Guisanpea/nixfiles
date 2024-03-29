{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      # Terminal
      git
      neovim
      wget
      zsh
      # Desktop
      firefox-wayland
    ];
    variables.EDITOR = "nvim";
    sessionVariables.NIXOS_OZONE_WL = "1";
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gnome-text-editor
    ]) ++ (with pkgs.gnome; [
      atomix # puzzle game
      cheese
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gedit # text editor
      gnome-calculator
      gnome-characters
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-notes
      gnome-software
      gnome-system-monitor
      gnome-terminal
      gnome-weather
      hitori # sudoku game
      iagno # go game
      simple-scan
      tali # poker game
      totem # video player
    ]);
  };

  fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; }) ];
}
