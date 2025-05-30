# Git configuration that is common across all systems
{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.git = {
    enable = true;
    extraConfig = {
      safe.directory = "/home/nixie/.dotfiles";
      init.defaultBranch = "main";
    };
    userName = "Santi";
    userEmail = "guisanpea" + "@" + "gmail.com";
  };
}
