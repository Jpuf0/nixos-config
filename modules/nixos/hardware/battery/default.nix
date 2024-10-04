{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.sakura.system.hardware.battery;
in {
  options.sakura.system.hardware.battery = {
    enable = mkEnableOption "Enable battery threshold serivce";
  };

  config = mkIf cfg.enable {
    systemd.services.battery = {
      enable = true;
      description = "Battery threshold service";
      wantedBy = ["multi-user.target"];
      after = ["multi-user.target"];
      serviceConfig = {
        StartLimitBurst = "0";
        Type = "oneshot";
        User = "root";
        Restart = "on-failure";
        # ExecStart = "/bin/sh -c 'echo -n $(cat /sys/class/power_supply/BAT0/capacity) > /sys/class/power_supply/BAT0/charge_control_start_threshold'";
        ExecStart = "/bin/sh -c 'echo -n 80 > /sys/class/power_supply/BAT0/charge_control_start_threshold'";
      };
    };
  };
}
