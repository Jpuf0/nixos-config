{...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      ControllerMode = "dual";
      Experimental = true;
      Enable = "Source,Sink,Media,Socket";
    };
  };

  services.blueman.enable = true;
}
