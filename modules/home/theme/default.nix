{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkMerge concatLists mkIf;
  inherit (lib.types) str enum bool;
  inherit (config.sakura.system.user) username;

  cfg = config.sakura.theme;
  enabled = cfg.qt.enable || cfg.catppuccin.enable;
  qtCfg = cfg.qt;
  catCfg = cfg.catppuccin;
in {
  options.sakura.theme = {
    qt = {
      enable = mkEnableOption "Enable QT theme";
      customPalette = mkEnableOption "Enable custom palette";

      standardDialogs = mkOption {
        type = enum ["default" "gtk3" "kde" "xdgdesktopportal"];
        default = "default";
        description = "Standard dialogs";
      };

      platformTheme = mkOption {
        type = str;
        description = "Platform theme for qt";
        default = "qt5ct";
      };

      style = mkOption {
        type = str;
        description = "Style for qt";
        default = "breeze";
      };

      iconTheme = mkOption {
        type = str;
        description = "Icon theme for qt";
      };

      colorScheme = mkOption {
        type = str;
        description = "Color scheme for qt";
        default = "simple";
      };
    };
    catppuccin = {
      enable = mkEnableOption "Enable Catppuccin theme";
      enableQT = mkEnableOption "Enable Catppuccin theme for QT";
      global = mkOption {
        type = bool;
        description = "Enable Catppuccin theme globally";
        default = false;
      };

      flavor = mkOption {
        type = enum ["latte" "frappe" "macchiato" "mocha"];
        description = "Catppuccin flavor";
        default = "mocha";
      };
      accent = mkOption {
        type = enum ["blue" "flamingo" "green" "lavender" "maroon" "mauve" "peach" "pink" "red" "rosewater" "sapphire" "sky" "teal" "yellow"];
        description = "Catppuccin accent";
      };
    };
    /*
       gtk = {
      enable = mkEnableOption "Enable GTK theme";
      font = mkOption {
        type = str;
        description = "Font for GTK theme";
        default = "Noto Sans";
      };
      size = mkOption {
        type = int;
        description = "Size for GTK theme";
        default = 11;
      };
      iconTheme = {
        name = mkOption {
          type = str;
          description = "Icon theme for GTK theme";
          default = "Papirus-Dark";
        };
        package = mkOption {
          type = package;
          description = "Icon theme package for GTK theme";
          default = pkgs.catppuccin-papirus-folders.override {
            inherit (catCfg) flavor;
            inherit (catCfg) accent;
          };
        };
      };
    };
    */
  };

  config = mkMerge [
    (mkIf (enabled && catCfg.enable) {
      home-manager.users."${username}" = {
        imports = [
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
      catppuccin = {
        enable = catCfg.global;
        inherit (catCfg) flavor;
        inherit (catCfg) accent;
      };

      qt = mkIf (catCfg.enableQT) {
        style.catppuccin = {
          enable = true;
          inherit (catCfg) flavor;
          inherit (catCfg) accent;
        };
      };
    })

    (mkIf (enabled && qtCfg.enable) {
      qt = {
        enable = true;
        inherit (qtCfg) platformTheme;
        inherit (qtCfg) style;
      };

      home-manager.users."${username}" = {
        home.packages = with pkgs; [
          tela-icon-theme
          kdePackages.qtstyleplugin-kvantum
          kdePackages.qt6ct
        ];

        xdg.configFile = {
          "Kvantum/kvantum.kvconfig".text = mkIf (qtCfg.style == "kvantum") ''
            [General]
            theme=LayanDark
          '';

          "Kvantum/LayanDark".source = mkIf (qtCfg.style == "kvantum") "${pkgs.layan}/share/Kvantum/Layan";
        };
      };

      nixpkgs.overlays = [
        (self: super: {
          layan-kde = super.layan-kde.overrideAttrs (old: {
            patches = concatLists [
              (old.patches or [])
              [./layan.patch]
            ];
          });
        })
      ];
    })
  ];
}
