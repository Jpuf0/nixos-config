local mainMod = "SUPER"

hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("show-keybinds"))

-- hl.define_submap("global", function()
-- = = = APP MENU = = = --
hl.bind("SUPER + D", hl.dsp.global("caelestia:launcher"), { release = true })
-- hl.bind("catchall", hl.dsp.global("caelestia:launcherInterrupt"), { ignore_mods = true, non_consuming = true })
hl.bind(mainMod .. " + mouse:272", hl.dsp.global("caelestia:launcherInterrupt"),
  { ignore_mods = true, non_consuming = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.global("caelestia:launcherInterrupt"),
  { ignore_mods = true, non_consuming = true })
hl.bind(mainMod .. " + mouse:274", hl.dsp.global("caelestia:launcherInterrupt"),
  { ignore_mods = true, non_consuming = true })
hl.bind(mainMod .. " + mouse:275", hl.dsp.global("caelestia:launcherInterrupt"),
  { ignore_mods = true, non_consuming = true })
hl.bind(mainMod .. " + mouse:276", hl.dsp.global("caelestia:launcherInterrupt"),
  { ignore_mods = true, non_consuming = true })
hl.bind(mainMod .. " + mouse:277", hl.dsp.global("caelestia:launcherInterrupt"),
  { ignore_mods = true, non_consuming = true })
hl.bind(mainMod .. " + mouse_up", hl.dsp.global("caelestia:launcherInterrupt"),
  { ignore_mods = true, non_consuming = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.global("caelestia:launcherInterrupt"),
  { ignore_mods = true, non_consuming = true })

hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.global("caelestia:session"))

hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), { locked = true })
-- keybindings

hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("ALT + Return", hl.dsp.exec_cmd("kitty --title float_kitty"))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty --start-as=fullscreen -o 'font_size=16'"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("[workspace 1 silent] zen"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + Space", hl.dsp.window.float())
-- hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 .waybar-wrapped"))
-- hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))
-- hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("$HOME/.local/bin/toggle_layout"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill wofi || wallpaper-picker"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("zen"))
-- Clipboard and emoji picker
hl.bind("SUPER + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"))
hl.bind("SUPER + ALT + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard -d"))
hl.bind("SUPER + Period", hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"))

-- screenshot
-- hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grimblast --notify save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"))
-- hl.bind("Print", hl.dsp.exec_cmd("grimblast --notify copy area"))
hl.bind("ALT + SHIFT + s",
  hl.dsp.exec_cmd("grimblast --notify --freeze copysave area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"))

-- switch focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- switch using tab
hl.bind(mainMod .. " + tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))

-- switch workspace / move to workspace silently
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false })) -- movetoworkspacesilent
end

hl.bind(mainMod .. " + backspace", hl.dsp.workspace.toggle_special("minimized"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.window.move({ workspace = "special:minimized" }))

-- window control
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -80, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 80, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -80, relative = true }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 80, relative = true }))
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.move({ x = -80, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ x = 80, y = 0, relative = true }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.move({ x = 0, y = -80, relative = true }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.move({ x = 0, y = 80, relative = true }))

-- media and volume controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 2"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 2"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- mouse binding
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hl.on("hyprland.start", function()
--   hl.dispatch(hl.dsp.submap("global"))
-- end)
-- end)
