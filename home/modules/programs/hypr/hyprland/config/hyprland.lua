local hm_xdg_config_home = os.getenv("XDG_CONFIG_HOME") or "/home/jpuf/.config"
package.path = hm_xdg_config_home .. "/hypr/?.lua;" .. hm_xdg_config_home .. "/hypr/?/init.lua;" .. package.path
require("variables")
require("settings")
require("animations")
require("binds")
require("rules")

hl.on("hyprland.start", function()
  hl.exec_cmd(
  "/nix/store/2avx2c74smgw4ghki0qlnc0scgpfycbl-dbus-1.16.2/bin/dbus-update-activation-environment --systemd --all && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
  hl.notification.create({ text = "Hyprland started", time = 3000 })
end)

hl.on("config.reloaded", function()
  hl.notification.create({ text = "Config reloaded", time = 3000 })
end)
