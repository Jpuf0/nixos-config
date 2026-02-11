{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    themeFile = "Catppuccin-Mocha";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      background_opacity = "0.55";
      window_padding_width = 10;
      scrollback_lines = 10000;
      enable_audio_bell = true;
      mouse_hide_wait = 60;

      ## Tabs
      tab_title_template = "{index}";
      active_tab_font_style = "normal";
      inactive_tab_font_style = "normal";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      active_tab_foreground = "#1e1e2e";
      active_tab_background = "#cba6f7";
      inactive_tab_foreground = "#bac2de";
      inactive_tab_background = "#313244";

      ## fish done plugin
      remote_control_password = "\"kitty-rc-password\" ls";
      allow_remote_control = "password";

      ## fun
      cursor_trail = "3";
      cursor_trail_decay = "0.1 0.4";
    };

    keybindings = {
      ## Tabs
      "ctrl+1" = "goto_tab 1";
      "ctrl+2" = "goto_tab 2";
      "ctrl+3" = "goto_tab 3";
      "ctrl+4" = "goto_tab 4";
      "ctrl+5" = "goto_tab 5";
      "ctrl+6" = "goto_tab 6";
      "ctrl+7" = "goto_tab 7";
      "ctrl+8" = "goto_tab 8";
      "ctrl+9" = "goto_tab 9";
      "ctrl+0" = "goto_tab 0";

      ## Unbind
    };
  };
}
