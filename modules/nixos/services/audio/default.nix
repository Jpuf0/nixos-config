{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.sakura.system.services.pipewire;
in {
  options.sakura.system.services.pipewire = {
    enable = mkEnableOption "Enable PipeWire";
    lowLatency = mkEnableOption "Enable low latency mode";
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      extraConfig.pipewire."92-low-latency" = mkIf cfg.lowLatency {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 64;
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 64;
        };
      };
    };

    security.rtkit.enable = true;
  };
}
