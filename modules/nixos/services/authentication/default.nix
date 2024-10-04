{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) enum;

  cfg = config.sakura.system.services.polkit;
in {
  options.sakura.system.services.polkit = {
    enable = mkEnableOption "Enable Polkit";
    agents = mkOption {
      type = enum ["gnome" "kde" "qt5"];
      description = "Polkit agents";
      default = "gnome";
    };
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;

    systemd = {
      user.services.polkit-gnome-agent = mkIf (cfg.agents == "gnome") {
        description = "polkit_gnome Polkit authentication agent";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
      user.services.polkit-kde-agent = mkIf (cfg.agents == "kde") {
        description = "kdePackages.polkit-kde-agent-1 Polkit authentication agent";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
      user.services.polkit-qt5-agent = mkIf (cfg.agents == "qt5") {
        description = "libsForQt5.polkit-kde-agent Polkit authentication agent";
        wantedBy = ["default.target"];
        wants = ["default.target"];
        after = ["default.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
}
