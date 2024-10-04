{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption mkMerge mkIf;
  inherit (lib.types) enum;

  cfg = config.sakura.system.hardware.cpu;
in {
  options.sakura.system.hardware.cpu = {
    type = mkOption {
      type = enum ["intel" "amd"];
      description = "CPU type";
      default = "intel";
    };
  };

  config = mkMerge [
    (mkIf (cfg.type == "amd") {
      hardware.cpu.amd = {
        updateMicrocode = true;
      };
    })

    (mkIf (cfg.type == "intel") {
      hardware.cpu.intel = {
        updateMicrocode = true;
      };

      services.throttled.enable = true;
    })
  ];
}
