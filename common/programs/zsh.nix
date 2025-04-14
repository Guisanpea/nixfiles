{ pkgs, config, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        k = "kubectl";
        ls = "eza";
        ll = "eza -l";
        la = "eza -la";
        anix = "${config.home.homeDirectory}/.dotfiles/apply-arch.sh";
        nanix = "${config.home.homeDirectory}/.dotfiles/apply-arch.sh --no-git";
        mnix = "${config.home.homeDirectory}/.dotfiles/apply-mac.sh";
        unix = "${config.home.homeDirectory}/.dotfiles/update.sh";
        csf = "./vendor/bin/php-cs-fixer fix";
        doom = "~/.config/emacs/bin/doom";
        archpath = "export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/.nix-profile' | grep -v '/nix/var/nix/profiles' | tr '\n' ':' | sed 's/:$//')";
        # Development aliases
        asdf = "true";
        eenv = "export $(grep -v '^#' ./.env | xargs)";
        renv = "export $(grep -v '^#' ../.env | xargs)";
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
        {
          name = "bd";
          src = pkgs.zsh-bd;
          file = "share/zsh-bd/bd.plugin.zsh";
        }
        {
          name = "you-should-use";
          src = pkgs.zsh-you-should-use;
          file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
        }
      ];
    };
    starship.enable = true;
    starship.enableZshIntegration = true;
  };
}
