hl.curve("fluent_decel", { type = "bezier", points = { { 0, 0.2 }, { 0.4, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.33, 1 }, { 0.68, 1 } } })
hl.curve("easeinoutsine", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })

-- Windows
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "easeOutCubic", style = "popin 30%" })  -- window open
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "fluent_decel", style = "popin 70%" }) -- window close
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "easeinoutsine", style = "slide" })   -- everything in between, moving, dragging, resizing

-- Fade
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "easeOutCubic" })                       -- fade in (open) -> layers and windows
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "easeOutCubic" })                      -- fade out (close) -> layers and windows
hl.animation({ leaf = "fadeSwitch", enabled = false, speed = 1, bezier = "easeOutCirc" })                   -- fade on changing activewindow and its opacity
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 10, bezier = "easeOutCirc" })                   -- fade on changing activewindow for shadows
hl.animation({ leaf = "fadeDim", enabled = true, speed = 4, bezier = "fluent_decel" })                      -- the easing of the dimming of inactive windows
hl.animation({ leaf = "border", enabled = true, speed = 2.7, bezier = "easeOutCirc" })                      -- for animating the border's color switch speed
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "fluent_decel", style = "once" }) -- for animating the border's gradient angle - styles: once (default), loop
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutCubic", style = "fade" })   -- styles: slide, slidevert, fade, slidefade, slidefadevert
