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
#	flashback.customSessions = [
#	  {
#	    wmCommand = "${pkgs.i3-gaps}/bin/i3";
#	    wmLabel = "Gnome i3";
#	    wmName = "gnome3-i3";
	  #}
	#];
      };
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };
  
}
