{ pkgs, ... }:

let
  dotfiles = pkgs.fetchFromGitHub {
    owner = "Guisanpea";
    repo = "dotfiles";
    rev = "75553067a8bf30688e0ba40045a37d8ad06ab279";
    sha256 = "1q1arrpsmzzqzc6zrgiizrcxw5x6p82xg900wywxixp7gmq9mm88";
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraConfig = ''
source ~/.config/nvim/config/editor.vim
source ~/.config/nvim/config/abbrv.vim
source ~/.config/nvim/config/plugins.vim
source ~/.config/nvim/config/pluginsconf.vim
source ~/.config/nvim/config/theme.vim
'';
  };

  xdg.configFile."nvim/config".source = "${dotfiles}/nvim/config";
  xdg.dataFile = {
    "vim-plug" = {
      target = "nvim/site/autoload/plug.vim";
      source = (builtins.fetchTarball {
        url = "https://github.com/junegunn/vim-plug/archive/master.tar.gz";
      }) + "/plug.vim";
    };
  };
}
