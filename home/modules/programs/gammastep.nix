{pkgs, ...}: {
  services.gammastep = {
    enable = true;
    duskTime = "18:35-20:15";
    dawnTime = "6:00-7:45";

    temperature = {
      day = 5500;
      night = 3700;
    };

    # Tray Icon
    tray = true;

    provider = "manual";

    latitude = "50.806784";
    longitude = "-1.097782";

    settings = {
      general = {
        adjustment-method = "wayland";
      };
    };
  };
}
