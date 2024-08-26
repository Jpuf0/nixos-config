{inputs, ...}: {
  imports =
    [(import ./hyprland)]
    ++ [(import ./hypridle)]
    ++ [(import ./hyprpaper)]
    ++ [(import ./hyprlock)];
}
