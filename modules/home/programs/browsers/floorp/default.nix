{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.sakura.system.user) username;
  cfg = config.sakura.programs.browsers.floorp;
in {
  options.sakura.programs.browsers.floorp = {
    enable = mkEnableOption "Zen Browser module.";
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}".home.packages = with pkgs; [
      floorp
    ];
  };
}
