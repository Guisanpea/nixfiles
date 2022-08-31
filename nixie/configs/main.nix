{ config, pkgs, lib, ... }:

{
  imports = [
    ./rofi.nix
    ./zsh.nix
    ./mime-apps.nix
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
  };
}

