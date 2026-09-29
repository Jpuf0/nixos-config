self: {
  config,
  lib,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.programs.mwb;
in {
  options.programs.mwb = {
    enable = lib.mkEnableOption "Mouse Without Borders client";

    package = lib.mkOption {
      type = lib.types.package;
      default = self.packages.${system}.mwb-linux;
    };

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Users added to the input group (needed for uinput)";
    };

    extraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["-bidi" "-edge" "left"];
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [cfg.package];

    boot.kernelModules = ["uinput"];
    services.udev.packages = [cfg.package];

    users.users = lib.genAttrs cfg.users (_: {
      extraGroups = ["input"];
    });

    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [15100 15101];

    systemd.user.services.mwb = {
      description = "Mouse Without Borders for Linux";
      after = ["graphical-session.target" "network-online.target"];
      wants = ["network-online.target"];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe cfg.package} ${lib.escapeShellArgs cfg.extraArgs}";
        Restart = "on-failure";
        RestartSec = 5;
      };
    };
  };
}
