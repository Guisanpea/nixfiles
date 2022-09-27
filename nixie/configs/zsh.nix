{ pkgs, lib, ... }:


let
  dotfiles = ../../.config;
in
{
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "exa";
      unix = "/home/nixie/.dotfiles/update.sh";
      snix = "/home/nixie/.dotfiles/apply-system.sh";
    };
    initExtra = "export PATH=$PATH:~/.local/npm/bin";
    # https://github.com/NixOS/nixpkgs/issues/27587
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = pkgs.zsh-autosuggestions.pname;
        file = "zsh-autosuggestions.zsh";
        src = "${pkgs.zsh-autosuggestions}/share/${pkgs.zsh-autosuggestions.pname}";
      }
      {
        name = pkgs.zsh-syntax-highlighting.pname;
        file = "zsh-syntax-highlighting.zsh";
        src = "${pkgs.zsh-syntax-highlighting}/share/${pkgs.zsh-syntax-highlighting.pname}";
      }
      {
        name = "main";
        src = dotfiles;
        file = "zsh/main.zsh";
      }
      {
        name = "aliases";
        src = dotfiles;
        file = "zsh/aliases.zsh";
      }
      {
        name = "autostart";
        src = dotfiles;
        file = "zsh/autostart.zsh";
      }
      {
        name = "bash private functions";
        src = /home/nixie/.config/bash;
        file = "functions.sh";
      }
      {
        name = "zsh-z";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
      {
        name = "p10k-conf";
        file = "zsh-z.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "agkozak";
          repo = "zsh-z";
          rev = "595c883abec4682929ffe05eb2d088dd18e97557";
          sha256 = "0kf78p1k8d6kzcqjcxn1nfki6p76kqiv4zlc89zzhsphmid18z0y";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
  };
}

