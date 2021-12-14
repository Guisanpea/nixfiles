{ config, pkgs, ... }:

let
  #dotfiles = ~/git/dotfiles;
  dotfiles = pkgs.fetchFromGitHub {
    owner = "Guisanpea";
    repo = "dotfiles";
    rev = "a9fd3fa8de644c73ac800e92115aa84e2bba4863";
    sha256 = "EmyZqdmbHSKlTiBEHNZHqn9+Tqc3asanQu/tece8PK0=";
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

  home.packages = with pkgs; [
    cowsay fortune feh openssl ripgrep
    jetbrains.idea-ultimate 
    arandr konsole gnome3.dconf-editor
    lutris-free
    slack tdesktop
  ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = "${dotfiles}/doom.d";
    emacsPackage = pkgs.emacsPgtkGcc;
    emacsPackagesOverlay = self: super: {
      gitignore-mode = pkgs.emacsPackages.git-modes;
      gitconfig-mode = pkgs.emacsPackages.git-modes;
      erlang = super.erlang.overrideAttrs (esuper: {
        buildInputs = esuper.buildInputs ++ [ pkgs.perl pkgs.ncurses ];
      });
    };
  };

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
    ./packages/main.nix
  ];
}
