# macOS-specific home configuration
{ lib, config, pkgs, ... }:

{
  imports = [
    ../common/home.nix
    ./packages.nix
  ];

  home = {
    sessionPath = [
      "$HOME/.rd/bin"
    ];
    homeDirectory = lib.mkForce "/Users/ssanchez";
  };
}
