{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;

  cfg = config.sakura.system.displaymanagers;
in {
  options.sakura.system.displaymanagers = {
    sddm.enable = mkEnableOption "Enable SDDM display manager.";
    regreetd.enable = mkEnableOption "Enable Regreet display manager.";
  };

  config = mkMerge [
    (mkIf (cfg.sddm.enable) {
      services.displayManager.sddm = {
        enable = true;
        autoNumlock = true;
        wayland.enable = true;
      };
    })

    (mkIf (cfg.regreetd.enable) {
      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
            user = "greeter";
          };
        };
      };

      programs.regreet = {
        enable = true;
        package = pkgs.greetd.regreet;

        settings = {
          commands = {
            reboot = ["systemctl" "reboot"];
            poweroff = ["systemctl" "poweroff"];
          };
          appearance = {
            greeting_msg = "Welcome back!";
          };
        };
      };
    })
  ];
}
