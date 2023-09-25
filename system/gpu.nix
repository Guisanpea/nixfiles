{ pkgs, ... }: {
  # Enable big navi support
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl = { enable = true; };
  # Enable vulkan
  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
    rocm-opencl-icd
    rocm-opencl-runtime
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
}
