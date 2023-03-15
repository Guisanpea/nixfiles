{ pkgs, ... }: {
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
    desktopManager = {
      gnome = {
        enable = true;
      };
    };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "nixie";
      };
      default_session = initial_session;
    };
  };
}
