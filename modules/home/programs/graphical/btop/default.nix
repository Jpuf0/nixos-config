{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkMerge;
  inherit (config.sakura.system.user) username;

  cfg = config.sakura.programs.btop;
  gpu = config.sakura.system.hardware.gpu;

  catppuccin = config.sakura.theme.catppuccin;
in {
  options.sakura.programs.btop = {
    enable = mkEnableOption "Enable btop module.";
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}" = {
      programs.btop = {
        enable = true;

        catppuccin = mkIf catppuccin.enable {
          enable = true;
          inherit (catppuccin) flavor;
        };
      };
      home.packages = with pkgs;
        mkMerge [
          (mkIf (gpu.type == "nvidia") [
            nvtopPackages.nvidia
          ])
          (mkIf (gpu.type == "amd") [
            nvtopPackages.amd
          ])
        ];
    };
  };
}
