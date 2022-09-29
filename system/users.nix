{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixie = {
    isNormalUser = true;
    isSystemUser = false;
    extraGroups = [ "wheel" "docker" "adbusers" ]; # Enable ‘sudo’ for the user.
  };

  users.defaultUserShell = pkgs.zsh;

  nix.settings.trusted-users = [ "root" "nixie" ];
}
