# Common home configuration shared across all systems
{ config, ... }:

let
  dotfiles = ../dotconfig;
in
{
  imports = [
    ./packages.nix
    ./programs/default.nix
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };


  # Common dotfile configurations
  xdg.configFile = {
    "tmux".source = "${dotfiles}/tmux";
    "doom".source = "${dotfiles}/doom";
    "wezterm".source = "${dotfiles}/wezterm";
    "nvim_init" = {
      source = "${dotfiles}/nvim";
      recursive = true;
      # This is a hack to make the nvim directory writable
      onChange = ''
        rm -rf ${config.xdg.configHome}/nvim
        mkdir -p ${config.xdg.configHome}/nvim
        cd ${config.xdg.configHome}/nvim_init
        for file in $(find . -type f -o -type l); do
          target_dir=$(dirname "${config.xdg.configHome}/nvim/$file")
          mkdir -p "$target_dir"
          cp $(readlink -f "$file") "${config.xdg.configHome}/nvim/$file"
        done
        chmod -R u+w ${config.xdg.configHome}/nvim
      '';
    };
  };


  # This value determines the Home Manager release that your
  # configuration is compatible with
  home.stateVersion = "20.09";
}
