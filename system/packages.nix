{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [
      # Terminal
      git neovim wget zsh
      # Desktop
      firefox
    ];
    variables.EDITOR = "nvim";
  };

  programs.adb.enable = true;

  fonts.fonts = with pkgs; [ nerdfonts ];

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
