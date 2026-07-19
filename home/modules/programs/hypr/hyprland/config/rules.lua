-- windowrule = match:class (wofi), pin on
-- windowrule = match:class (wofi), float on
-- windowrule = match:class (wofi), noborder on

hl.window_rule({ name = "udiskie", match = { class = "(udiskie)" }, float = true })
hl.window_rule({ name = "transmission", match = { title = "^(Transmission)$" }, float = true })
hl.window_rule({ name = "volume-control", match = { title = "^(Volume Control)$" }, float = true, size = "700 450", move =
"40 55%" })
hl.window_rule({ name = "zen-sharing-indicator", match = { title = "^(zen-beta — Sharing Indicator)$" }, float = true, move =
"0 0" })
hl.window_rule({ name = "pip", match = { title = "^(Picture-in-Picture)$" }, float = true, opacity =
"1.0 override 1.0 override", pin = true })
hl.window_rule({ name = "youtube-opacity", match = { title = "^(.*YouTube.*)$" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ name = "discord-popout", match = { initial_title = "^(Discord Popout)$" }, float = true, opacity =
"1.0 override 1.0 override", pin = true })
hl.window_rule({ name = "imv", match = { class = "(imv)" }, float = true, center = true, size = "1200 725" })
hl.window_rule({ name = "imv-opacity", match = { title = "^(.*imv.*)$" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ name = "mpv", match = { class = "(mpv)" }, float = true, center = true, size = "1200 725" })
hl.window_rule({ name = "mpv-opacity", match = { title = "^(.*mpv.*)$" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ name = "unity-opacity", match = { class = "(Unity)" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ name = "zen-beta-opacity", match = { class = "(zen-beta)" }, opacity = "1.0 override 1.0 override" })
hl.window_rule({ name = "mpv-idle-inhibit", match = { class = "^(mpv)$" }, idle_inhibit = "focus" })
hl.window_rule({ name = "zen-beta-idle-inhibit", match = { class = "^(zen-beta)$" }, idle_inhibit = "fullscreen" })

hl.window_rule({ name = "float-kitty", match = { title = "^(float_kitty)$" }, float = true, center = true, size =
"950 600" })

hl.window_rule({ name = "pavucontrol", match = { class = "^(pavucontrol)$" }, float = true })
hl.window_rule({ name = "soundwireserver", match = { class = "^(SoundWireServer)$" }, float = true })
hl.window_rule({ name = "file-progress", match = { class = "^(file_progress)$" }, float = true })
hl.window_rule({ name = "confirm", match = { class = "^(confirm)$" }, float = true })
hl.window_rule({ name = "dialog", match = { class = "^(dialog)$" }, float = true })
hl.window_rule({ name = "download", match = { class = "^(download)$" }, float = true })
hl.window_rule({ name = "notification", match = { class = "^(notification)$" }, float = true })
hl.window_rule({ name = "error", match = { class = "^(error)$" }, float = true })
hl.window_rule({ name = "confirmreset", match = { class = "^(confirmreset)$" }, float = true })
hl.window_rule({ name = "open-file", match = { title = "^(Open File)$" }, float = true })
hl.window_rule({ name = "branchdialog", match = { title = "^(branchdialog)$" }, float = true })
hl.window_rule({ name = "confirm-replace-files", match = { title = "^(Confirm to replace files)$" }, float = true })
hl.window_rule({ name = "file-operation-progress", match = { title = "^(File Operation Progress)$" }, float = true })

hl.window_rule({
  name = "shimeji",
  match = { class = "DesktopPets" },
  float = true,
  no_blur = true,
  no_focus = false,
  no_shadow = true,
  border_size = 0,
  opacity = "1.0",
})
