{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  primeConfig = config.hardware.nvidia.prime;
in {
  config = {
    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      nvidiaSettings = false;

      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    environment = {
      sessionVariables = {
        "__EGL_VENDOR_LIBRARY_FILENAMES" = "${config.hardware.nvidia.package}/share/glvnd/egl_vendor.d/10_nvidia.json";
      };
    };
    boot = {
      kernelParams = [
        "nvidia.NVreg_UsePageAttributeTable=1"
        "nvidia.NVreg_TemporaryFilePath=/var/tmp"
      ];
      blacklistedKernelModules = ["nouveau"];
    };
  };
}
