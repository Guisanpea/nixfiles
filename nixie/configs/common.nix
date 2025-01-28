{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh.nix
  ];

  programs = {
    command-not-found.enable = true;
    git = {
      enable = true;
      extraConfig = {
        safe.directory = "/home/nixie/.dotfiles";
      };
      userName = "Santi";
      userEmail = "guisanpea" + "@" + "gmail.com";
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

