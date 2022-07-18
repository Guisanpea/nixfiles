self: super: {
  waybar = super.waybar.override {
    pulseSupport = true;
    withMediaPlayer = true;
  };

  neofetch = super.neofetch.overrideAttrs (oldAttrs: {
    src = builtins.fetchTarball
      "https://github.com/dylanaraps/neofetch/archive/master.tar.gz";
  });
  discord = super.discord.overrideAttrs (_: {
    src = builtins.fetchTarball
      "https://discord.com/api/download?platform=linux&format=tar.gz";
  });
  jetbrains = super.jetbrains // {
    idea-community = super.jetbrains.idea-community.overrideAttrs (_: {
      name = "idea-community.2022.1.3";
      src = builtins.fetchTarball
        "https://download.jetbrains.com/idea/ideaIU-2022.1.3.tar.gz";
    });
    phpstorm = super.jetbrains.phpstorm.overrideAttrs (_: {
      name = "phpstorm.2022.1";
      src = builtins.fetchTarball
        "https://download.jetbrains.com/webide/PhpStorm-2022.1.tar.gz";
    });
  };
}
