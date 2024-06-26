{...}: {
  programs.waybar.settings.mainBar = {
    position = "bottom";
    layer = "top";
    height = 5;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
      "custom/media"
    ];
    modules-center = [
      "clock"
    ];
    modules-right = [
      "tray"
      "cpu"
      "memory"
      "disk"
      "pulseaudio"
      "network"
    ];
    clock = {
      format = " {:%H:%M (%Z)}";
      tooltip = "true";
      tooltip-format = "<big>{:%a %d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = " {:%d/%m}";
      timezones = [
        "Europe/London"
        "US/Eastern"
        "Asia/Manila"
      ];
      calendar = {
        format = {
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
      actions = {
        on-scroll-up = "tz_up";
        on-scroll-down = "tz_down";
      };
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "󰈹";
        "2" = "";
        "3" = "󰘙";
        "4" = "󰙯";
        "5" = "";
        "6" = "";
        urgent = "";
        default = "";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
    };
    memory = {
      format = "󰟜 {}%";
      format-alt = "󰟜 {used} GiB"; # 
      interval = 2;
    };
    cpu = {
      format = "  {usage}%";
      format-alt = "  {avg_frequency} GHz";
      interval = 2;
    };
    disk = {
      # path = "/";
      format = "󰋊 {percentage_used}%";
      interval = 60;
    };
    network = {
      format-wifi = "  {signalStrength}%";
      format-ethernet = "󰀂 {bandwidthDownOctets}  {bandwidthUpOctets} ";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "󰖪 ";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    battery = {
      states = {
        "good" = 80;
        "warning" = 30;
        "critical" = 20;
      };
      format = "{icon} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-plugged = " {capacity}%";
      format-alt = "{time} {icon}";
      format-icons = [
        "󰂃"
        "󰁺"
        "󰁻"
        "󰁼"
        "󰁽"
        "󰁾"
        "󰁿"
        "󰂀"
        "󰂁"
        "󰂂"
        "󰁹"
      ];
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "󰖁 ";
      format-icons = {
        default = [" "];
      };
      scroll-step = 5;
      # on-click = "pamixer -t";
    };
    "custom/launcher" = {
      format = "";
      on-click = "pkill wofi || wofi --show drun";
      on-click-right = "pkill wofi || wallpaper-picker";
      tooltip = "false";
    };
    "custom/media" = {
      interval = 5;
      format = "{}";
      exec = "playerctl metadata -f '{{ uc(status)}}: {{artist}} - {{title}}'";
      on-click = "playerctl play-pause";
      enable-bar-scroll = true;
      max-length = "4";
      escape = true;
    };
  };
}
