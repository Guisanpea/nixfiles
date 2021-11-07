self: super: {
  neofetch = super.neofetch.overrideAttrs (oldAttrs: {
    src = builtins.fetchTarball
      "https://github.com/dylanaraps/neofetch/archive/master.tar.gz";
  });
  discord = super.discord.overrideAttrs (_: {
    src = builtins.fetchTarball
      "https://discord.com/api/download?platform=linux&format=tar.gz";
  });
  jetbrains = super.jetbrains // {
    idea-ultimate = super.jetbrains.idea-ultimate.overrideAttrs (_: {
      name = "idea-ultimate.2021.2.1";
      src = super.fetchurl {
        url = "https://download.jetbrains.com/idea/ideaIU-2021.2.1.tar.gz";
        sha256 = "4bbd3966c79c9e3d871d7b82668d6685f93deb143b675bca7ce4755b193777e4";
      };
    });
  };
}
