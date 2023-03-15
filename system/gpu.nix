{ pkgs, ... }: {
  # Enable big navi support
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [ "radeon.cik_support=0" "amdgpu.cik_support=1" "radeon.si_support=0" "amdgpu.si_support=1" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl = {
    enable = true;
  };
  # Enable vulkan
  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
}
