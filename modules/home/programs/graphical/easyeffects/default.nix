{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.sakura.system.user) username;

  cfg = config.sakura.programs.easyeffects;
  inputContent = builtins.readFile ./input/default.json;
  outputContent = builtins.readFile ./output/default.json;
in {
  options.sakura.programs.easyeffects = {
    enable = mkEnableOption "Enable easyeffects module.";
  };

  config = mkIf cfg.enable {
    programs.dconf.enable = true;

    home-manager.users."${username}" = {
      services.easyeffects.enable = true;

      xdg.configFile = {
        "easyeffects/autoload/input/default.json".text = inputContent;
        "easyeffects/input/default.json".text = inputContent;
        "easyeffects/autoload/output/default.json".text = outputContent;
        "easyeffects/output/default.json".text = outputContent;
      };
    };
  };
}
