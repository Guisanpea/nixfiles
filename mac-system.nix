{ pkgs, lib, config, ... }: {
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys =
    [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
  nix.settings.trusted-users = [ "@admin" ];

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # https://github.com/nix-community/home-manager/issues/423
  programs.nix-index.enable = true;


  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  ids.gids.nixbld = 30000;

  system.stateVersion = 5;
}
