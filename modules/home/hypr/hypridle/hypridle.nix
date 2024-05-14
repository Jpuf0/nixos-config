{
  inputs,
  ...
}: {
  services.hypridle = {
    enable = true;

    lockCmd = "pidof hyprlock || hyprlock";
    beforeSleepCmd = "loginctl lock-session";
    afterSleepCmd = "hyprctl dispatch dpms on";
    ignoreDbusInhibit = true;

    listeners = [
      {
        timeout = 300;
        onTimeout = "loginctl lock-session";
      }
      {
        timeout = 330;
        onTimeout = "hyprctl dispatch dpms off";
        onResume = "hyprctl dispatch dpms on" ;
      }
      {
        timeout = 3000;
        onTimeout = "systemctl suspend";
      }
    ];
  };
}