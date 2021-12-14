{ pkgs, ... }:

{

# Home Manager programs.firefox style
programs.firefox = {
  enable = true;
  package = pkgs.wrapFirefox pkgs.firefox-devedition-bin-unwrapped {
    forceWayland = true;
    extraPolicies = {
      ExtensionSettings = {};
    };
  };
};
}
