{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf"];
    };

    initExtraFirst = ''
      DISABLE_MAGIC_FUNCTIONS=true
      export "MICRO_TRUECOLOR=1"
    '';

    shellAliases = with lib;
    with pkgs; {
      cat = "${getExe bat}";

      # Utils
      c = "clear";
      cd = "z";
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
      rebuild = "sudo nixos-rebuild switch --impure --flake ~/.nixos#";
      rebuildu = "sudo nixos-rebuild switch --upgrade --impure --flake ~/.nixos#";

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

    /*
       plugins = with pkgs; [
      {
        name = "zsh-forgit";
        src = zsh-forgit;
        file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
      }
      {
        name = "zsh-fzf-tab";
        src = zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
    ]
    */
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    settings =
      {
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

        palette = "catppuccin_mocha";
      }
      // builtins.fromTOML (builtins.readFile "${inputs.catppuccin-starship}/palettes/mocha.toml");
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
