{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.sakura.programs.opentablet;
in {
  options.sakura.programs.opentablet = {
    enable = mkEnableOption "Enable opentablet module.";
  };

  config = mkIf cfg.enable {
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
      package = pkgs.opentabletdriver;
    };
  };
}
