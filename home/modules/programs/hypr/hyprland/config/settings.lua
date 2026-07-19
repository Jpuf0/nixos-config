hl.env("NIXOS_OZONE_WL", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "1920x0", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 2 })

hl.on("hyprland.start", function()
  -- systemd.enable = true; variables = ["--all"]; in hyprland.nix already makes
  -- home-manager emit an equivalent dbus-update-activation-environment call into
  -- the generated hyprland.lua's own startup hook (see lib.nix renderStartHook) —
  -- these three are redundant with that.
  -- hl.exec_cmd("systemctl --user import-environment")
  -- hl.exec_cmd("hash dbus-update-activation-environment 2>/dev/null")
  -- hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  hl.exec_cmd("nm-applet")
  -- hl.exec_cmd("wl-paste --primary --watch wl-copy --primary --clear")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  -- hl.exec_cmd("sleep 1 && hyprlock")
  -- hl.exec_cmd("background-changer")
  hl.exec_cmd("hyprctl setcursor Nordzy-cursors 22")
end)

hl.config({
  debug = { disable_logs = false },

  input = {
    kb_layout = "us",
    numlock_by_default = true,
    follow_mouse = 1,
    sensitivity = 0,
  },

  cursor = { no_hardware_cursors = true },

  misc = {
    disable_autoreload = true,
    disable_hyprland_logo = true,
    always_follow_on_dnd = true,
    layers_hog_keyboard_focus = true,
    animate_manual_resizes = false,
    enable_swallow = true,
    swallow_regex = "^(Alacritty|kitty)$",
    focus_on_activate = false,
  },

  general = {
    layout = "dwindle",
    gaps_in = 8,
    gaps_out = 18,
    border_size = 3,
    col = {
      active_border = { colors = { "rgb(cba6f7)", "rgb(94e2d5)" }, angle = 45 },
      inactive_border = "rgba(00000000)",
    },
    -- gaps_in = 5,
    -- gaps_out = 10,
    -- border_size = 2,
    -- col = { active_border = { colors = { "rgb(cba6f7)", "rgb(94e2d5)" }, angle = 45 }, inactive_border = "rgba(00000000)" },
    -- border_part_of_window = false,
  },

  xwayland = { force_zero_scaling = true },

  dwindle = {
    force_split = 0,
    special_scale_factor = 1.0,
    split_width_multiplier = 1.0,
    use_active_for_splits = true,
    preserve_split = true,
  },

  master = {
    new_status = "master",
    special_scale_factor = 1, -- xdg-desktop-portal-hyprland
  },

  decoration = {
    rounding = 5,
    active_opacity = 0.90,
    inactive_opacity = 0.90,
    fullscreen_opacity = 1.0,
    blur = {
      enabled = true,
      size = 4,
      passes = 2,
      brightness = 1,
      contrast = 1.3,
      ignore_opacity = true,
      noise = 0.0117,
      new_optimizations = true,
      xray = true,
    },
    shadow = {
      enabled = true,
      offset = { 0, 2 },
      range = 20,
      render_power = 3,
      color = "rgba(00000055)",
    },
  },

  animations = { enabled = true },
})
