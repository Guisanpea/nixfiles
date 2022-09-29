{ config, pkgs, ... }:

let
  dotfiles = ../.config;
  astronvim = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "ba775276324b75e4f703cd63fea3cfe7726514de";
    sha256 = "tMHi5P/EmYoRYp6kdRGxSWJ3o1EPxVk+V6OkRc5ly0Y=";
  };
in
{
  nixpkgs.overlays = [
    (import ./overlays/main.nix)
  ];

  imports = [
    ./packages/cli.nix
  ];

  programs.home-manager.enable = true;

  xdg.configFile."tmux".source = "${dotfiles}/tmux";
  xdg.configFile."doom".source = "${dotfiles}/doom.d";
  xdg.configFile."nvim".source = "${astronvim}";
  home.file.".npmrc".source = "${dotfiles}/npmrc";

  home.stateVersion = "20.09";
}
