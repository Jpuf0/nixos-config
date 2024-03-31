{config, pkgs, inputs, ...}: {
  imports = [inputs.nixos-hardware.nixosModules.dell-xps-15-9500-nvidia];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
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
  powerManagement.powertop.enable = true;
}
