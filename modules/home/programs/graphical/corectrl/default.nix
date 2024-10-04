{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.sakura.programs.corectrl;
in {
  options.sakura.programs.corectrl = {
    enable = mkEnableOption "Enable corectrl module.";
  };

  config = mkIf cfg.enable {
    programs.corectrl = {
      enable = true;
      gpuOverclock.enable = true;
    };
  };
}
