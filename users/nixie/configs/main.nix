{ config, pkgs, lib, ... }:

{
  imports = [
    ./polybar.nix
    ./rofi.nix
    ./alacritty.nix
    ./compton.nix
    ./zsh.nix
    ./nvim.nix
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

