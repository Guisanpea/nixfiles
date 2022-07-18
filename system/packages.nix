{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [
      # Terminal
      git neovim wget zsh
      # Desktop
      firefox-wayland
    ];
    variables.EDITOR = "nvim";
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


  fonts.fonts = with pkgs; [ font-awesome nerdfonts ];

  nixpkgs = {
    overlays = [
      (self: super: {
        neovim = super.neovim.override {
          viAlias = true;
          vimAlias = true;
          configure = {
            packages.myVimPackage = with pkgs.vimPlugins; {
              start = [ vim-nix ];
              opt = [ ];
            };      
          };
        };
      })
    ];
  };
}
