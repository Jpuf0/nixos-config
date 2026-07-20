{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.fish = {
    enable = true;

    shellAliases = import ./aliases.nix;

    functions = import ./functions.nix {inherit pkgs lib;};

    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf.fish";
        src = fzf-fish.src;
      }
      {
        name = "fifc";
        src = fifc.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
      {
        name = "done";
        src = done.src;
      }
      {
        name = "grc";
        src = grc.src;
      }
    ];
    # // import ./plugins.nix {inherit pkgs lib;};

    shellInit = ''
      # Disable fish greeting
      set -g fish_greeting

      # Set fish colors
      set -g fish_color_command blue
      set -g fish_color_param cyan
      set -g fish_color_redirection yellow
      set -g fish_color_comment brblack
      set -g fish_color_error red
      set -g fish_color_escape magenta
      set -g fish_color_operator green
      set -g fish_color_quote yellow
      set -g fish_color_autosuggestion brblack
      set -g fish_color_valid_path --underline

      # Set default editor
      set -gx EDITOR vim

      # Enable vi mode
      # fish_vi_key_bindings

      # Configure plugins
      set fzf_diff_highlighter delta --paging=never --width=20
      set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

      set -Ux fifc_editor $EDITOR

      set -U __done_notification_command "notify-send -i utilities-terminal "\$title" "\$message""
      set -U __done_notify_sound 1
      set -U __done_allow_nongraphical 1
      set -U __done_kitty_remote_control 1
      set -U __done_kitty_remote_control_password "kitty-rc-password"
    '';

    interactiveShellInit = ''
      # Custom prompt setup if needed
      # (starship should handle this if you're using it)
      zoxide init --cmd cd fish | source

      # Set up fzf key bindings if fzf is available
      # if command -v fzf >/dev/null
      #   fzf_key_bindings
      # end

      fzf_configure_bindings --history=
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings =
      {
        right_format = "$cmd_duration";
        scan_timeout = 60;

        directory = {
          format = "[ ](bold #89b4fa)[ $path ]($style)";
          style = "bold #b4befe";
        };

        character = {
          success_symbol = "[ ](bold #89b4fa)[ ➜](bold green)";
          # error_symbol = "[ ](bold #89b4fa)[ ➜](bold red)";
          error_symbol = "[ ](bold #89dceb)[ ✗](bold red)";
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
      // fromTOML (builtins.readFile "${inputs.catppuccin-starship}/themes/mocha.toml");
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
