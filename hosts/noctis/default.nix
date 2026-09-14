{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  networking.hostName = "noctis";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-59-6.19.11"
      "broadcom-sta-6.30.223.271-59-7.0.3"
      "broadcom-sta-6.30.223.271-59-7.0.6"
      "broadcom-sta-6.30.223.271-59-7.0.9"
      "broadcom-sta-6.30.223.271-59-7.0.10"
      "broadcom-sta-6.30.223.271-59-7.1.2"
      "broadcom-sta-6.30.223.271-63-7.2.3"
      "broadcom-sta-6.30.223.271-63-6.18.50"
      "electron-38.8.4"
      "electron-40.10.5"
    ];
  };

  boot = {
    # LTS while testing whether broadcom-sta (wl) is more stable than on zen 7.2
    kernelPackages = pkgs.linuxPackages;
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
    enableAllHardware = true;
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
