{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = {
      displayManager = {
	extraSessionFilePackages = let gnome-flashback-xmonad = pkgs.callPackage ({ stdenv, gnome3, bash, haskellPackages, glib, wrapGAppsHook }: stdenv.mkDerivation {
	    name = "gnome-flashback-xmonad";

	    buildInputs = [ gnome3.gnome-flashback gnome3.gnome-panel bash haskellPackages.xmonad glib ];
	    nativeBuildInputs = [ wrapGAppsHook ];

	    unpackPhase = "true";

	    installPhase = ''
	      mkdir -p $out/libexec
	      cat << EOF > $out/libexec/gnome-flashback-xmonad
	      #!${bash}/bin/sh
	      if [ -z \$XDG_CURRENT_DESKTOP ]; then
		export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
	      fi
	      exec ${gnome3.gnome-session}/bin/gnome-session --session=gnome-flashback-xmonad --disable-acceleration-check "\$@"
	      EOF
	      chmod +x $out/libexec/gnome-flashback-xmonad
	      mkdir -p $out/share/gnome-session/sessions
	      cat << 'EOF' > $out/share/gnome-session/sessions/gnome-flashback-xmonad.session
	      [GNOME Session]
	      Name=GNOME Flashback (XMonad)
	      RequiredComponents=xmonad;gnome-flashback-init;gnome-flashback;gnome-panel;org.gnome.SettingsDaemon.A11ySettings;org.gnome.SettingsDaemon.Clipboard;org.gnome.SettingsDaemon.Color;org.gnome.SettingsDaemon.Datetime;org.gnome.SettingsDaemon.Housekeeping;org.gnome.SettingsDaemon.Keyboard;org.gnome.SettingsDaemon.MediaKeys;org.gnome.SettingsDaemon.Mouse;org.gnome.SettingsDaemon.Power;org.gnome.SettingsDaemon.PrintNotifications;org.gnome.SettingsDaemon.Rfkill;org.gnome.SettingsDaemon.ScreensaverProxy;org.gnome.SettingsDaemon.Sharing;org.gnome.SettingsDaemon.Smartcard;org.gnome.SettingsDaemon.Sound;org.gnome.SettingsDaemon.Wacom;org.gnome.SettingsDaemon.XSettings;
	      EOF
	      mkdir -p $out/share/applications
	      cat << 'EOF' > $out/share/applications/xmonad.desktop
	      [Desktop Entry]
	      Type=Application
	      Encoding=UTF-8
	      Name=Xmonad
	      Exec=${haskellPackages.xmonad}/bin/xmonad
	      NoDisplay=true
	      X-GNOME-WMName=Xmonad
	      X-GNOME-Autostart-Phase=WindowManager
	      X-GNOME-Provides=windowmanager
	      X-GNOME-Autostart-Notify=false
	      EOF
	      mkdir -p $out/share/xsessions
	      cat << EOF > $out/share/xsessions/gnome-flashback-xmonad.desktop
	      [Desktop Entry]
	      Name=GNOME Flashback (XMonad)
	      Comment=This session logs you into GNOME Flashback with XMonad
	      Exec=$out/libexec/gnome-flashback-xmonad
	      TryExec=${haskellPackages.xmonad}/bin/xmonad
	      Type=Application
	      DesktopNames=GNOME-Flashback;GNOME;
	      EOF
	    '';
	  })
	  {};
	  in [ gnome-flashback-xmonad ];
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      xkbOptions = "caps:ctrl_modifier";

    };
  };
}
