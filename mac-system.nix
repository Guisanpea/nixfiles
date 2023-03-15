{ pkgs, lib, config, ... }: {
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys =
    [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  nix.settings.trusted-users = [ "@admin" ];
  nix.configureBuildUsers = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [ kitty terminal-notifier ];

  # https://github.com/nix-community/home-manager/issues/423
  programs.nix-index.enable = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" "FiraCode" ]; })
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
        echo "setting up ~/Applications/Nix..."
        rm -rf ~/Applications/Nix
        mkdir -p ~/Applications/Nix
        chown ssanchez ~/Applications/Nix
        find ${config.system.build.applications}/Applications -maxdepth 1 -type l | while read f; do
          src="$(/usr/bin/stat -f%Y $f)"
          appname="$(basename $src)"
          osascript -e "tell app \"Finder\" to make alias file at POSIX file \"/Users/ssanchez/Applications/Nix/\" to POSIX file \"$src\" with properties {name: \"$appname\"}";
      done
    ''
  );

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position = "bottom";
      height = 28;
      title = "on";
      spaces = "on";
      power = "on";
      clock = "off";
      right_shell = "off";
      padding_left = 20;
      padding_right = 20;
      spacing_left = 25;
      spacing_right = 25;
      text_font = ''"FiraCode Nerd Font:16.0"'';
      icon_font = ''"FiraCode Nerd Font:16.0"'';
      background_color = "0xffFFFFFF";
      foreground_color = "0xff161616";
      space_icon_color = "0xff3ddbd9";
      power_icon_strip = " ";
      space_icon_strip = "一 二 三 四 五 六 七 八 九 十";
      spaces_for_all_displays = "on";
      display_separator = "on";
      display_separator_icon = "|";
      clock_format = ''"%d/%m/%y %R"'';
      right_shell_icon = " ";
      right_shell_command = "whoami";
    };
  };
}
