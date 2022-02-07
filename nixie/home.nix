{ config, pkgs, ... }:

let
  # dotfiles = ~/git/dotfiles;
  dotfiles = pkgs.fetchFromGitHub {
    owner = "Guisanpea";
    repo = "dotfiles";
    rev = "771494b73b439994f9c4a213d04deb929a8656d";
    sha256 = "6DC7I2OIYsslFb2qhp3dq9HjrFidezzpEwp3zQtVGD0=";
  };
in
{
  nixpkgs.overlays = [
    (import ./overlays/main.nix)
  ];

  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixie";
  home.homeDirectory = "/home/nixie";
  home.sessionPath = ["$HOME/git/phpactor/bin" "$HOME/git/elixir-ls/release"];

  home.packages = with pkgs; [
    cowsay fortune feh openssl ripgrep
    jetbrains.idea-ultimate 
    arandr konsole gnome3.dconf-editor
    lutris-free
    slack tdesktop
  ];

  # programs.doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = "${dotfiles}/doom.d";
  #   emacsPackage = pkgs.emacsPgtkGcc;
  #   emacsPackagesOverlay = self: super: {
  #     gitignore-mode = pkgs.emacsPackages.git-modes;
  #     gitconfig-mode = pkgs.emacsPackages.git-modes;
  #     erlang = super.erlang.overrideAttrs (esuper: {
  #       buildInputs = esuper.buildInputs ++ [ pkgs.perl pkgs.ncurses ];
  #     });
  #   };
  # };

  xdg.configFile."i3".source = "${dotfiles}/i3";
  xdg.configFile."tmux".source = "${dotfiles}/tmux";
  xdg.configFile."alacritty".source = "${dotfiles}/alacritty";
  xdg.configFile."sway/config".source = "${dotfiles}/sway/config.config";
  xdg.configFile."waybar".source = "${dotfiles}/waybar";
  home.file.".Xresources".source = "${dotfiles}/.Xresources";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  imports = [
    ./configs/main.nix
    ./packages.nix
  ];
}
