{
  location.provider = "geoclue2";
  services.geoclue2.enable = true;

  time = {
    timeZone = "Europe/London";
    hardwareClockInLocalTime = true;
  };
}
