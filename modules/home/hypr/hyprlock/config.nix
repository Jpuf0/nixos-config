{...}: {
  programs.hyprlock = {
    general = {
      disable_loading_bar = true;
      grace = 3;
      hide_cursor = true;
      no_fade_in = false;
      no_fade_out = false;
      ignore_empty_input = false;
    };
    backgrounds = [];
    input-fields = [];
    sources = [
      "$HOME/.cache/wal/colors-sway"
    ];
    extraConfig = "
background {
  monitor =
  path = $HOME/.current_wallpaper
  color = $color7

  # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
  blur_size = 4
  blur_passes = 3 # 0 disables blurring
  noise = 0.0117
  contrast = 1.3000 # Vibrant!!!
  brightness = 0.8000
  vibrancy = 0.2100
  vibrancy_darkness = 0.0
}

input-field {
  monitor =
  size = 250, 50
  outline_thickness = 3
  dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
  dots_spacing = 0.64 # Scale of dots' absolute size, 0.0 - 1.0
  dots_center = true
  outer_color = $color1
  inner_color = $color0
  font_color = $color7
  fade_on_empty = true
  placeholder_text = <i>Password...</i> # Text rendered in the input box when it's empty.
  hide_input = false
  position = 0, 50
  halign = center
  valign = bottom
}

# Current time
label {
  monitor =
  text = cmd[update:1000] echo \"<b><big> $(date +\"%H:%M:%S\") </big></b>\"
  color = $color0
  font_size = 64
  font_family = JetBrains Mono Nerd Font 10
  position = 0, 16
  halign = center
  valign = center
}

# User label
label {
  monitor =
  text = Hey <span text_transform=\"capitalize\" size=\"larger\">$USER</span>
  color = $color0
  font_size = 20
  font_family = JetBrains Mono Nerd Font 10
  position = 0, 0
  halign = center
  valign = center
}


# Type to unlock
label {
  monitor =
  text = Type to unlock!
  color = $color0
  font_size = 16
  font_family = JetBrains Mono Nerd Font 10
  position = 0, 30
  halign = center
  valign = bottom
}
    ";
  };
}