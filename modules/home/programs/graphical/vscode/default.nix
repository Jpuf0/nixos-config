{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf;
  inherit (lib.types) package;
  inherit (inputs.home-manager.lib.hm) dag;
  inherit (config.sakura.system.user) username;

  userPath = "${config.xdg.configHome}/${configDir}/User/settings.json";

  readJSON = file: builtins.fromJSON (builtins.readFile file);

  mergeSettings = nixSettings:
    if builtins.pathExists userPath
    then lib.attrsets.recursiveUpdate nixSettings (readJSON userPath)
    else nixSettings;

  cfg = config.sakura.programs.vscode;
  configDir =
    {
      "vscode" = "Code";
      "vscode-insiders" = "Code - Insiders";
      "vscodium" = "VSCodium";
    }
    .${cfg.package.pname};
in {
  options.sakura.programs.vscode = {
    enable = mkEnableOption "Enable VSCode";
    mutable = mkEnableOption "Enable VSCode mutable";
    package = mkOption {
      type = package;
      description = "VSCode package";
      default = pkgs.vscodium;
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [inputs.nix-vscode-extensions.overlays.default];

    home-manager.users."${username}" = {
      home = {
        activation = mkIf cfg.mutable {
          removeExistingVSCodeSettings = dag.entryBefore ["checkLinkTargets"] ''
            rm -rf "${userPath}"
          '';

          overwriteVSCodeSymlink = let
            userSettings = config.programs.vscode.userSettings;
            jsonSettings = pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings);
          in
            dag.entryAfter ["linkGeneration"] ''
              rm -rf "${userPath}"
              cat ${jsonSettings} | ${pkgs.jq}/bin/jq --monochrome-output > "${userPath}"
            '';
        };
      };

      program.vscode = {
        enable = true;
        extensions = import ./extensions.nix {inherit pkgs;};
        userSettings = import ./settings.nix {inherit pkgs;};
      };
    };
  };
}
