{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-15-9500-nvidia
  ];

  networking.hostName = "ghost";

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = ["quiet"];
    consoleLogLevel = 0;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 3;
    };
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;

    nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

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

    logind = {
      settings = {
        Login = {
          HandlePowerKey = "suspend"; # default "poweroff"
          HandlePowerKeyLongPress = "poweroff"; # default "ignore"
          # HandleRebootKey= ""; # default "reboot"
          # HandleRebootKeyLongPress= ""; # default "poweroff"
          # HandleSuspendKey= ""; # default "suspend"
          # HandleSuspendKeyLongPress= ""; # default "hibernate"
          # HandleHibernateKey= ""; # default "hibernate"
          # HandleHibernateKeyLongPress= ""; # default "ignore"
          HandleLidSwitch = "suspend"; # default "suspend"
          # HandleLidSwitchExternalPower = "lock"; # completely ignored by default (for backwards compatibility) — an explicit value must be set before it will be used to determine behaviour.
          # HandleLidSwitchDocked= ""; # default "ignore"
          # HandleSecureAttentionKey= ""; # default "secure-attention-key"
        };
      };
      # powerKey = "suspend";
      # lidSwitch = "suspend";
      # lidSwitchExternalPower = "lock";
    };

    upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
    power-profiles-daemon.enable = true;
  };
}
