# Common home configuration shared across all systems
{ config, pkgs, ... }:

let
  dotfiles = ../dotconfig;
in
{
  imports = [
    ./packages.nix
    ./programs/git.nix
    ./programs/php.nix
  ];

  # Enable PHP configuration
  home-manager = {
    extraSpecialArgs = { inherit pkgs; };
    users.ssanchez.programs.php.enable = true;
  };

  # Common dotfile configurations
  xdg.configFile = {
    "tmux".source = "${dotfiles}/tmux";
    "doom".source = "${dotfiles}/doom.d";
  };
  
  home.file.".npmrc".source = "${dotfiles}/npmrc";

  # This value determines the Home Manager release that your
  # configuration is compatible with
  home.stateVersion = "20.09";
}
