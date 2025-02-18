{ pkgs, config, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        k = "kubectl";
        ls = "eza";
        anix = "${config.home.homeDirectory}/.dotfiles/apply-arch.sh";
        nanix = "${config.home.homeDirectory}/.dotfiles/apply-arch.sh --no-git";
        mnix = "${config.home.homeDirectory}/.dotfiles/apply-mac.sh";
        unix = "${config.home.homeDirectory}/.dotfiles/update.sh";
        csf = "./vendor/bin/php-cs-fixer fix";
        asdf = "true";
        doom = "~/.config/emacs/bin/doom";
        archpath = "export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/.nix-profile' | grep -v '/nix/var/nix/profiles' | tr '\n' ':' | sed 's/:$//')";
      };
      initExtra = ''
        bindkey "^[[1;5C" forward-word # Ctrl + right
        bindkey "^[[1;5D" backward-word # Ctrl + left
      '';
      plugins = [
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
          name = pkgs.zsh-z.pname;
          file = "zsh-z.plugin.zsh";
          src = "${pkgs.zsh-z}/share/zsh-z";
        }
      ];
    };
    starship.enable = true;
    starship.enableZshIntegration = true;
  };
}
