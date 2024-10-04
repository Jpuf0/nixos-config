{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.sakura.system.services.ssh;
in {
  options.sakura.system.services.ssh = {
    enable = mkEnableOption "Enable SSH";
  };

  config = mkIf cfg.enable {
    services.openssh.enable = true;
  };
}
