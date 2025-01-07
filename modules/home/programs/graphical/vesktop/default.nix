{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf concatLists;
  inherit (lib.types) enum;
  inherit (config.sakura.system.user) username;

  cfg = config.sakura.programs.vesktop;
  catppuccin = config.sakura.theme.catppuccin;

  themeName =
    catppuccin.flavor
    + (
      if catppuccin.accent != null
      then "-${catppuccin.accent}"
      else ""
    );
in {
  options.sakura.programs.vesktop = {
    enable = mkEnableOption "Enable vesktop module.";
    branch = mkOption {
      type = enum ["canary" "stable" "ptb"];
      description = "Branch to use";
      default = "stable";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs; [
        # (vesktop.overrideAttrs (old: {
        #   patches = concatLists [
        #     (old.patches or [])
        #     [
        #       ./vesktop.patch
        #     ]
        #   ];
        # }))
        vesktop
      ];

      xdg.configFile = {
        "vesktop/themes/catppuccin-${themeName}.css".text = mkIf catppuccin.enable ''
          /**
          * @name Catppuccin  ${themeName}
          * @author winston#0001
          * @authorId 505490445468696576
          * @version 0.2.0
          * @description 🎮 Soothing pastel theme for Discord
          * @website https://github.com/catppuccin/discord
          * @invite r6Mdz5dpFc
          * **/

          @import url("https://catppuccin.github.io/discord/dist/catppuccin-${themeName}.theme.css");
        '';

        "vesktop/settings.json".text = builtins.toJSON {
          minimiseToTray = "on";
          discordBranch = cfg.branch;
          arRPC = "on";
          splashColor = "oklab(0.899401 -0.00192499 -0.00481987)";
          splashBackground = "oklab(0.321088 -0.000220731 -0.00934622)";
        };
      };
    };
  };
}
