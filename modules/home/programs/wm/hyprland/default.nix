{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption mkIf optionals concatLists genList;
  inherit (lib.types) str listOf nullOr;
  inherit (config.sakura.system.user) username;

  cfg = config.sakura.programs.hyprland;

  # Helper function to validate a single monitor configuration
  validateMonitor = m: let
    parts = lib.splitString "," m;
    isValidResolution = res: let
      # Match either "WidthxHeight" or "WidthxHeight@RefreshRate"
      match = builtins.match "^([0-9]+x[0-9]+)(@[0-9]+)?$" res;
    in
      match != null;
    isValidPosition = pos: builtins.match "^[0-9]+x[0-9]+$" pos != null;
    isValidScale = scale: builtins.match "^[0-9]+(\\.[0-9]+)?$" scale != null;
  in
    if builtins.length parts < 3 || builtins.length parts > 4
    then throw "Invalid monitor configuration: ${m}. Expected format: name,resolution,position[,scale]"
    else if !isValidResolution (builtins.elemAt parts 1)
    then throw "Invalid resolution in monitor configuration: ${m}. Expected format: WidthxHeight or WidthxHeight@RefreshRate"
    else if !isValidPosition (builtins.elemAt parts 2)
    then throw "Invalid position in monitor configuration: ${m}. Expected format: XxY"
    else if builtins.length parts == 4 && !isValidScale (builtins.elemAt parts 3)
    then throw "Invalid scale in monitor configuration: ${m}. Expected a number or decimal"
    else m;

  processMonitors = let
    defaultMonitor = ",preferred,auto,${toString cfg.scaling}";
  in
    if cfg.monitors == null || cfg.monitors == []
    then defaultMonitor
    else
      lib.concatMapStrings (
        m: let
          validatedMonitor = validateMonitor m;
          parts = lib.splitString "," validatedMonitor;
          name = builtins.elemAt parts 0;
          resolution = builtins.elemAt parts 1;
          position = builtins.elemAt parts 2;
          scale =
            if builtins.length parts > 3
            then builtins.elemAt parts 3
            else toString cfg.scaling;
        in "monitor=${name},${resolution},${position},${scale}\n"
      )
      cfg.monitors;
in {
  options.sakura.programs.hyprland = {
    #TODO: Add support for nvidia since nvidia is fucked on linux

    enable = mkEnableOption "Enable Hyprland";
    enableDebug = mkEnableOption "Enable debug mode";
    enableOldSystemPatches = mkEnableOption "Enable old system patches";

    monitors = mkOption {
      type = nullOr (listOf str);
      description = "Monitors to use with Hyprland";
      default = null;
      example = [
        "DP-1,1920x1080@60,0x0,1"
        "HDMI-A-1,3840x2160@60,1920x0"
      ];
    };

    scaling = mkOption {
      type = str;
      description = "Monitor Scaling for hyprland";
      default = "1";
    };
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      portalPackage = inputs.xdg-desktop-portal-hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
    };

    home-manager.users."${username}" = {
      home.packages = with pkgs; [
        swww
        inputs.hypr-contrib.packages."${pkgs.system}".grimblast
        wofi
        grim
        slurp
        wl-clipboard
        cliphist
        wl-clipboard
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        xwayland = {
          enable = true;
        };

        systemd = {
          enable = true;
          variables = ["--all"];
        };

        settings = {
          "$mainMod" = "SUPER";

          monitor = processMonitors;

          exec-once = [
          ];

          env = concatLists [
            [
              "XDG_SESSION_TYPE, wayland"
              "GDK_BACKEND, wayland,x11"
              "SDL_VIDEODRIVER, wayland"
              "CLUTTER_BACKEND, wayland"
              "QT_QPA_PLATFORM, wayland;xcb"
              "HYPRCURSOR_THEME, rose-pine-hyprcursor"
              "HYPRCURSOR_SIZE,30"

              "GDK_SCALE, ${cfg.scaling}"

              "XDG_CURRENT_DESKTOP, Hyprland"
              "XDG_SESSION_DESKTOP, Hyprland"
            ]
            (optionals cfg.enableDebug [
              "HYPRLAND_LOG_WLR, 1"
              "HYPRLAND_TRACE, 1"
            ])
          ];

          debug = mkIf cfg.enableDebug {
            disable_logs = false;
          };

          input = {
            kb_layout = "us";
            follow_mouse = 1;
          };

          misc = {
            disable_autoreload = true;
            disable_hyprland_logo = true;
            always_follow_on_dnd = true;
            layers_hog_keyboard_focus = true;
            animate_manual_resizes = false;
            enable_swallow = true;
            swallow_regex = "^(Alacritty|kitty)$";
            focus_on_activate = false;

            vrr = 1;
            vfr = true;
          };

          general = {
            layout = "dwindle";

            gaps_in = 0;
            gaps_out = 0;
            border_size = 2;
            "col.active_border" = "rgb(cba6f7) rgb(94e2d5) 45deg";
            "col.inactive_border" = "0x00000000";
            border_part_of_window = true;
          };

          xwayland = {
            force_zero_scaling = true;
          };

          dwindle = {
            no_gaps_when_only = 0;
            force_split = 0;
            special_scale_factor = 1.0;
            split_width_multiplier = 1.0;
            use_active_for_splits = true;
            pseudotile = true;
            preserve_split = true;
          };

          master = {
            new_status = "master";
            special_scale_factor = 1;
          };

          decoration = {
            rounding = 5;

            active_opacity = 0.9;
            inactive_opacity = 0.7; # 0.90;
            fullscreen_opacity = 1.0;

            blur = {
              enabled = true;

              size = 4;
              passes = 2;

              brightness = 1;
              contrast = 1.3;
              ignore_opacity = true;
              noise = 0.011700;

              new_optimizations = true;
              xray = true;
            };

            drop_shadow = true;

            shadow_ignore_window = true;
            shadow_offset = "0 2";
            shadow_range = 20;
            shadow_render_power = 3;
            "col.shadow" = "rgba(00000055)";
          };

          animations = {
            enabled = true;

            bezier = [
              "fluent_decel, 0, 0.2, 0.4, 1"
              "easeOutCirc, 0, 0.55, 0.45, 1"
              "easeOutCubic, 0.33, 1, 0.68, 1"
              "easeinoutsine, 0.37, 0, 0.63, 1"
            ];

            animation = [
              "windowsIn, 1, 3, easeOutCubic, popin 30% # window open"
              "windowsOut, 1, 3, fluent_decel, popin 70% # window close."
              "windowsMove, 1, 2, easeinoutsine, slide # everything in between, moving, dragging, resizing."
              "fadeIn, 1, 3, easeOutCubic  # fade in (open) -> layers and windows"
              "fadeOut, 1, 2, easeOutCubic # fade out (close) -> layers and windows"
              "fadeSwitch, 0, 1, easeOutCirc # fade on changing activewindow and its opacity"
              "fadeShadow, 1, 10, easeOutCirc # fade on changing activewindow for shadows"
              "fadeDim, 1, 4, fluent_decel # the easing of the dimming of inactive windows"
              "border, 1, 2.7, easeOutCirc # for animating the border's color switch speed"
              "borderangle, 1, 30, fluent_decel, once # for animating the border's gradient angle - styles: once (default), loop"
              "workspaces, 1, 4, easeOutCubic, fade # styles: slide, slidevert, fade, slidefade, slidefadevert"
            ];
          };

          render = mkIf cfg.enableOldSystemPatches {
            explicit_sync = 0;
          };

          bind =
            [
              # Show keybind list
              "$mainMod, F1, exec, show-keybinds"

              # Main keybinds
              "$mainMod, M, exit,"
              "$mainMod, Return, exec, kitty"
              "ALT, Return, exec, kitty --title float_kitty"
              "$mainMod, C, killactive,"
              "$mainMod, F, fullscreen, 0"
              "$mainMod SHIFT, F, fullscreen, 1"
              "$mainMod, Space, togglefloating,"
              "$mainMod, D, exec, pkill wofi || wofi --show drun"
              "$mainMod, P, pseudo,"
              "$mainMod, J, togglesplit,"
              "$mainMod, E, exec, nemo"
              "$mainMod SHIFT, B, exec, pkill -SIGUSR1 .waybar-wrapped"
              "$mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

              # Screenshot
              "ALT+SHIFT, s, exec, grimblast --notify --freeze --cursor copysave area ~/Pictures/Screenshots/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"

              # Switch Focus
              "$mainMod, left, movefocus, l"
              "$mainMod, right, movefocus, r"
              "$mainMod, up, movefocus, u"
              "$mainMod, down, movefocus, d"

              # Windows-like Focus Switching
              "$mainMod, tab, workspace, m+1"
              "$mainMod SHIFT, tab, workspace, m-1"
            ]
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            ++ (
              concatLists (
                genList (
                  i: let
                    ws = i + 1;
                  in [
                    "$mainMod, code:1${toString i}, workspace, ${toString ws}"
                    "$mainMod SHIFT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
                  ]
                )
                10
              )
            )
            ++ [
              # Minimised Workspace
              "$mainMod, backspace, togglespecialworkspace, minimised"
              "$mainMod CTRL, C, movetoworkspacesilent, special:minimised"

              # Window Control
              "$mainMod SHIFT, left, movewindow, l"
              "$mainMod SHIFT, right, movewindow, r"
              "$mainMod SHIFT, up, movewindow, u"
              "$mainMod SHIFT, down, movewindow, d"
              "$mainMod CTRL, left, resizeactive, -80 0"
              "$mainMod CTRL, right, resizeactive, 80 0"
              "$mainMod CTRL, up, resizeactive, 0 -80"
              "$mainMod CTRL, down, resizeactive, 0 80"
              "$mainMod ALT, left, moveactive,  -80 0"
              "$mainMod ALT, right, moveactive, 80 0"
              "$mainMod ALT, up, moveactive, 0 -80"
              "$mainMod ALT, down, moveactive, 0 80"

              # Media, Brightness, Volume Controls
              ",XF86AudioRaiseVolume,exec, pamixer -i 2"
              ",XF86AudioLowerVolume,exec, pamixer -d 2"
              ",XF86AudioMute,exec, pamixer -t"
              ",XF86AudioPlay,exec, playerctl play-pause"
              ",XF86AudioNext,exec, playerctl next"
              ",XF86AudioPrev,exec, playerctl previous"
              ",XF86AudioStop,exec, playerctl stop"
              ",XF86MonBrightnessUp,exec, brightnessctl s +10"
              ",XF86MonBrightnessDown,exec, brightnessctl s 10-"
              "$mainMod, mouse_down, workspace, e-1"
              "$mainMod, mouse_up, workspace, e+1"
            ];

          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          windowrulev2 = [
            "center,class:^(imv)$"
            "center,class:^(mpv)$"
            "center,title:^(float_kitty)$"
            "float,class:^(confirm)$"
            "float,class:^(confirmreset)$"
            "float,class:^(dialog)$"
            "float,class:^(download)$"
            "float,class:^(error)$"
            "float,class:^(file_progress)$"
            "float,class:^(imv)$"
            "float,class:^(mpv)$"
            "float,class:^(notification)$"
            "float,class:^(pavucontrol)$"
            "float,class:^(SoundWireServer)$"
            "float,class:^(udiskie)$"
            "float,class:^(wofi)$"
            "float,title:^(branchdialog)$"
            "float,title:^(Confirm to replace files)$"
            "float,title:^(File Operation Progress)$"
            "float,title:^(float_kitty)$"
            "float,title:^(Open File)$"
            "float,title:^(Picture-in-Picture)$"
            "float,title:^(Volume Control)$"
            "idleinhibit focus, class:^(mpv)$"
            "idleinhibit fullscreen, class:^(zen-alpha)$"
            "move 40 55%,title:^(Volume Control)$"
            "noborder,class:^(wofi)$"
            "opacity 1.0 override 1.0 override, class:(zen-alpha)"
            "opacity 1.0 override 1.0 override, title:^(.*imv.*)$"
            "opacity 1.0 override 1.0 override, title:^(.*mpv.*)$"
            "opacity 1.0 override 1.0 override, title:^(.*YouTube.*)$"
            "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
            "pin, title:^(Picture-in-Picture)$"
            "pin,class:^(wofi)$"
            "size 1200 725,class:^(imv)$"
            "size 1200 725,class:^(mpv)$"
            "size 700 450,title:^(Volume Control)$"
            "size 950 600,title:^(float_kitty)$"
          ];
        };
      };
    };
  };
}
