{pkgs, inputs, ...}: {
  imports = [inputs.nixos-hardware.nixosModules.dell-xps-15-9500-nvidia];
  hardware.opengl = {
    enable = true;

    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.enableRedistributableFirmware = true;

  powerManagement.cpuFreqGovernor = "performance";
}
