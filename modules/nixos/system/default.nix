{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption concatLists;
  inherit (lib.types) str listOf;

  cfg = config.sakura.system;
in {
  options.sakura.system = {
    user = {
      username = mkOption {
        type = str;
        description = "Username";
      };

      description = mkOption {
        type = str;
        description = "User description";
      };

      extraGroups = mkOption {
        type = listOf str;
        description = "Extra groups";
        default = [];
      };

      initialPassword = mkOption {
        type = str;
        description = "Initial password";
        default = "nixos";
      };
    };

    timezone = mkOption {
      type = str;
      description = "Timezone";
      default = "Asia/Tokyo";
    };

    locale = mkOption {
      type = str;
      description = "Locale";
      default = "en_US.UTF-8";
    };

    hostname = mkOption {
      type = str;
      description = "Hostname";
      default = "sakura";
    };
  };

  config = {
    networking.hostName = cfg.hostname;

    system.stateVersion = "23.11";
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];

    programs.noshell.enable = true;

    users.users.${cfg.user.username} = {
      isNormalUser = true;
      description = cfg.user.description;
      initialPassword = cfg.user.initialPassword;
      extraGroups = concatLists [
        ["wheel"]
        cfg.user.extraGroups
      ];
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XDG_SESSION_TYPE = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
    };

    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.locale;

    services.upower.enable = true;
  };
}
