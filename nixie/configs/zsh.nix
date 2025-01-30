{ pkgs, lib, ... }:


{
  programs = {
    zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      k = "kubectl";
      ls = "eza";
      anix = "/home/archie/.dotfiles/apply-arch.sh";
      test-sway = "/home/archie/.dotfiles/scripts/sway-test.sh";
      mnix = "/Users/ssanchez/.dotfiles/apply-mac.sh";
      unix = "/home/nixie/.dotfiles/update.sh";
      snix = "/home/nixie/.dotfiles/apply-system.sh";
      csf = "./vendor/bin/php-cs-fixer fix";
      asdf = "true";
#      code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland --ozone-platform-hint=auto";
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
    ];
  };
    starship.enable = true;
    starship.enableZshIntegration = true;
    };
}

