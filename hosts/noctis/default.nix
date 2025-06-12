{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "noctis";

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = ["quiet"];
    consoleLogLevel = 0;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
    };
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;

    graphics = {
      enable = true;
      enable32Bit = true;
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
      enable = false;
      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };
}
