{...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      ControllerMode = "bredr";
      Experimental = true;
      Enable = "Source,Sink,Media,Socket";
    };
  };

  services.blueman.enable = true;
}
