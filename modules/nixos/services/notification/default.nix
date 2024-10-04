{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption;

  cfg = config.sakura.system.services.notification;
  xdg = config.sakura.xdg;
in {
  options.sakura.system.services.notification = {
    mako.enable = mkEnableOption "Enable mako notification daemon.";
    dunst.enable = mkEnableOption "Enable dunst notification daemon.";
  };

  config = {
    services.mako = {
      enable = cfg.mako.enable;
      font = "JetBrainsMono Nerd Font";
      padding = "15";
      defaultTimeout = 5000;
      borderSize = 2;
      borderRadius = 5;
      backgroundColor = "#1e1e2e";
      borderColor = "#b4befe";
      progressColor = "over #313244";
      textColor = "#cdd6f4";
      icons = true;
      actions = true;
      extraConfig = ''
        text-alignment=center
        [urgency=high]
        border-color=#fab387
      '';
    };

    services.dunst = {
      enable = cfg.dunst.enable;
      settings = {
        global = {
          monitor = 0;
          follow = "keyboard";
          width = 300;
          height = 100;
          offset = "+50x+50";
          origin = "top-right";

          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 1;
          progress_bar_min_width = 150;
          progress_bar_max_width = 300;

          indicate_hidden = true;

          shrink = "no";

          transparency = 10;

          separator_height = 2;

          padding = 8;

          horizontal_padding = 8;

          text_icon_padding = 0;

          frame_width = 2;

          frame_color = "#F37F97";

          seperate_color = "frame";

          sort = "yes";

          idle_threshold = 60;

          font = "JetBrainsMono Nerd Font 12";

          line_height = 0;
          markup = "full";
          format = "<b>%s</b>\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = 60;
          word_wrap = "yes";
          ellipsize = "middle";
          ignore_newline = "no";
          stack_duplicates = "yes";
          hide_duplicate_count = false;
          show_indicators = true;
          icon_position = "left";
          min_icon_size = 0;
          max_icon_size = 32;
          icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";
          sticky_history = "yes";
          history_length = 20;
          dmenu = "-i";
          browser = "${xdg.default_browser} -new-tab";
          always_run_script = true;
          title = "Dunst";
          class = "Dunst";
          corner_radius = 12;
          ignore_dbusclose = false;
          force_xwayland = false;
          force_xinerama = false;
          mouse_left_click = "do_action, close_current";
          mouse_middle_click = "close_current";
          mouse_right_click = "close_all";
        };
      };
    };
  };
}
