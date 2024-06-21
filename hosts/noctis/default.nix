{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "noctis";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services = {
    fstrim.enable = true;
    thermald.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    acpid.enable = true;
    hardware.bolt.enable = true;

    upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };
}
