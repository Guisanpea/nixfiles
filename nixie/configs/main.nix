{ config, pkgs, lib, ... }:

{
  imports = [
    ./rofi.nix
    ./zsh.nix
    ./nvim.nix
    ./mime-apps.nix
  ];

  programs = {
    command-not-found.enable = true;
    git = {
      enable = true;
      userName = "Santi";
      userEmail = "guisanpea" + "@" + "gmail.com";
    };
  };
}

