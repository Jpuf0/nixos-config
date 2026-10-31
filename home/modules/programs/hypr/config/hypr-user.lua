-- Loaded last by upstream hyprland.lua (require("hypr-user")), so anything here
-- overrides the caelestia defaults. Monitors and machine-specific tweaks go here.

hl.env("NIXOS_OZONE_WL", "1")

hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "1920x0", scale = 1 })

hl.config({
  input = {
    kb_layout          = "us",
    numlock_by_default = true,
  },

  -- NVIDIA
  cursor = { no_hardware_cursors = true },
})

hl.bind("CTRL + SUPER + V", hl.dsp.exec_cmd("wayvncctl output-cycle"))

-- local vnc_state = 0
-- hl.bind("CTRL + SUPER + V", function()
--   if vnc_state == 0 then
--     hl.dsp.exec_cmd("wayvncctl output-set --desktop")
--   end
-- end)
