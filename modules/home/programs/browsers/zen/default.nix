{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.sakura.system.user) username;
  cfg = config.sakura.programs.browsers.zen;
in {
  options.sakura.programs.browsers.zen = {
    enable = mkEnableOption "Zen Browser module.";
    dGPU = mkEnableOption "Enable dGPU support.";
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}".home.packages = with inputs.zen-browser.packages.${pkgs.system}; [
      default
    ];
  };
}
