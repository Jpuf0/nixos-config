{
  config,
  lib,
  self,
  inputs,
  ...
}: let
  inherit (config.sakura.system.user) username;
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) str;

  cfg = config.sakura.home-manager;

  home-directory = "/home/${username}";
in {
  options.sakura.home-manager = {
    enable = mkEnableOption "Home Manager";
    enableDirenv = mkEnableOption "direnv";

    homeDirectory = mkOption {
      type = str;
      description = "Location of the home directory";
      default = home-directory;
    };
  };

  config = mkIf cfg.enable {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = {inherit self inputs;};
      users."${username}" = {
        programs = {
          home-manager.enable = true;
          direnv = mkIf cfg.enableDirenv {
            enable = true;
            nix-direnv.enable = true;
            enableBashIntegration = true;
          };
        };

        home = {
          inherit (cfg) homeDirectory;
          stateVersion = "24.11";
        };
      };
    };
  };
}
