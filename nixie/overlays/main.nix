let
  idea-version = "2023.1";
  idea-sha256 = "3029c751c36d86fef0021feceb8f3010d37aebd42aef6d6aed9e3b9207c2d2ac";
in 
self: super: {
  jetbrains.idea-community = jetbrains.idea-community.overrideAttrs (_: {
    inherit idea-version;
    src = self.fetchurl {
      inherit idea-sha256;
      url = "https://download.jetbrains.com/idea/ideaIC-${version}.tar.gz";
    };
  })
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

}
