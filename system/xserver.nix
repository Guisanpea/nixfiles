{pkgs, ...}: {
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "altgr-intl";
    xkbOptions = "eurosign:e, caps:swapescape";
    deviceSection = ''
        Identifier      "AMD"
        Driver          "amdgpu"
        Option          "TearFree" "true"
    '';
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager = {
      gnome = {
        enable = true;
      };
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };
}
