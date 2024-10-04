{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf getExe;
  inherit (lib.types) listOf str;
  inherit (inputs.home-manager.lib.hm) dag;
  inherit (config.sakura.system) hostname;
  inherit (config.sakura.system.user) username;

  cfg = config.sakura.programs.shells.zsh;
in {
  options.sakura.programs.shells.zsh = {
    enable = mkEnableOption "Enable zsh shell.";
    enableCompletion = mkEnableOption "Enable zsh completion.";
    enableAutosuggestion = mkEnableOption "Enable zsh autosuggestions.";
    omz = {
      enable = mkEnableOption "Enable oh-my-zsh.";
      plugins = mkOption {
        type = listOf str;
        description = "Oh-my-zsh plugins";
        default = [];
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}" = {
      programs.zsh = {
        enable = true;
        enableCompletion = cfg.enableCompletion;
        autosuggestion = {
          enable = cfg.enableAutosuggestion;
        };

        oh-my-zsh = {
          enable = cfg.omz.enable;
          plugins = cfg.omz.plugins;
        };

        initExtraFirst = ''
          DISABLE_MICRO_SUGGESTIONS=true
          export "MICRO_TRUECOLOR=1"
        '';

        shellAliases = with lib;
        with pkgs; {
          cat = "${getExe bat}";
          bgrep = "${getExe bat-extras.batgrep}";

          # Utils
          c = "clear";
          cd = "z";
          fcd = "cd $(find -type d | fzf)";
          vim = "nvim";
          icat = "kitten icat";
          dsize = "du -hs";
          findw = "grep -rl";
          q = "exit";
          code = "codium";

          l = "${getExe eza} --icons  -a --group-directories-first -1"; #EZA_ICON_SPACING=2
          ll = "${getExe eza} --icons  -a --group-directories-first -1 --no-user --long";
          tree = "${getExe eza} --icons --tree --group-directories-first";

          # Nixos
          cdnix = "cd ~/.nixos && codium ~/.nixos";
          nix-shell = "nix-shell --run zsh";
          nix-switch = "sudo nixos-rebuild switch --impure --flake ~/.nixos#${hostname}";
          nix-switchu = "sudo nixos-rebuild switch --upgrade --impure --flake ~/.nixos#${hostname}";
          nix-flake-update = "sudo nix flake update ~/.nixos#";

          # Git
          ga = "git add";
          gaa = "git add --all";
          gs = "git status";
          gb = "git branch";
          gm = "git merge";
          gpl = "git pull";
          gplo = "git pull origin";
          gps = "git push";
          gpst = "git push --follow-tags";
          gpso = "git push origin";
          gc = "git commit";
          gcm = "git commit -m";
          gtag = "git tag -ma";
          gch = "git checkout";
          gchb = "git checkout -b";
          gcoe = "git config user.email";
          gcon = "git config user.name";

          # python
          piv = "python -m venv .venv";
          psv = "source .venv/bin/activate";
        };
      };

      home.activation = {
        noshellLink = dag.entryAfter ["writeBoundary" "createXdgUserDirectories"] ''
          if [[ ! -f "$HOME/.config/shell" ]]; then
            ln -s ${getExe pkgs.zsh} $HOME/.config/shell
          fi
        '';
      };
    };
  };
}
