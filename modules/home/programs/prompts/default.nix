{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.sakura.system.user) username;

  cfg = config.sakura.programs.prompt;
  catppuccin = config.sakura.theme.catppuccin;
in {
  options.sakura.programs.prompt = {
    starship = {
      enable = mkEnableOption "Enable starship shell.";
      enableBashIntegration = mkEnableOption "Enable starship bash integration.";
      enableZshIntegration = mkEnableOption "Enable starship zsh integration.";
    };
  };

  config = {
    home-manager.users."${username}" = {
      programs.starship = mkIf cfg.starship.enable {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;

        catppuccin = mkIf catppuccin.enable {
          enable = true;
          inherit (catppuccin) flavor;
        };

        settings = {
          right_format = "$cmd_duration";

          directory = {
            format = "[ ](bold #89b4fa)[ $path ]($style)";
            style = "bold #b4befe";
          };

          character = {
            success_symbol = "[ ](bold #89b4fa)[ ➜](bold green)";
            error_symbol = "[ ](bold #89b4fa)[ ➜](bold red)";
            # error_symbol = "[ ](bold #89dceb)[ ✗](bold red)";
          };

          cmd_duration = {
            format = "[]($style)[[󰔚 ](bg:#161821 fg:#d4c097 bold)$duration](bg:#161821 fg:#BBC3DF)[ ]($style)";
            disabled = false;
            style = "bg:none fg:#161821";
          };

          # directory.substitutions = {
          # "~" = "󰋞";
          # "Documents" = " ";
          # "Downloads" = " ";
          # "Music" = " ";
          # "Pictures" = " ";
          # };
        };
      };
    };
  };
}
