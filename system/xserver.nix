{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.pantheon.enable = true;
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
  
  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "altgr-intl";
  services.xserver.xkbOptions = "eurosign:e, caps:swapescape";
}
