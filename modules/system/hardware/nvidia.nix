{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;

  primeConfig = config.hardware.nvidia.prime;
in {
  config = {
    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement = {
          enable = true;
          finegrained = false;
        };

        prime.offload = {
          enable = mkIf (primeConfig.nvidiaBusId != "" && (primeConfig.intelBusId != "" || primeConfig.amdgpuBusId != "")) true;
          enableOffloadCmd = mkIf primeConfig.offload.enable true;
        };

        open = true;
        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  };
}
