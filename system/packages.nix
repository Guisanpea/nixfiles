{ pkgs, ... }: 
let 
  filteredNerdFonts = pkgs.nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "JetBrainsMono" ]; };
in {
  environment = {
    systemPackages = with pkgs; [
      # Terminal
      git neovim wget zsh
      # Desktop
      firefox-wayland
    ];
    variables.EDITOR = "nvim";
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gnome-text-editor
    ]) ++ (with pkgs.gnome; [
      atomix # puzzle game
      cheese
      empathy # chat clientam tool
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

  programs.waybar.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      alacritty # Alacritty is the default terminal in the config
      rofi-wayland # Dmenu is the default in the config but i recommend wofi since its wayland native
    ];
  };


  fonts.fonts = with pkgs; [ font-awesome filteredNerdFonts ];
}
