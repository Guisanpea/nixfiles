{pkgs, ...}: {
  hardware.pulseaudio.extraConfig =
    ''
      default-sample-rate = 48000
      alternate-sample-rate = 48000
    '';
  services.power-profiles-daemon.enable = false;
}

