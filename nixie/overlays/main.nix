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
  vscode = prev.vscode.overrideAttrs
    ({ buildInputs ? [ ], postFixup ? "", ... }: {
      buildInputs = buildInputs ++ [
        final.makeWrapper
      ];

      postFixup = postFixup + ''
        wrapProgram $out/bin/code \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    });
}
