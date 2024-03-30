{config, pkgs, inputs, ...}: {
  imports = [inputs.nixos-hardware.nixosModules.dell-xps-15-9500-nvidia];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.firmware = [
    pkgs.broadcom-bt-firmware
  ];
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  powerManagement.cpuFreqGovernor = "performance";
}
