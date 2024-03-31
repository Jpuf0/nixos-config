{inputs, ...}: {
  imports =
    [(import ./hyprland)]
    ++ [(import ./hypridle)]
    ++ [(import ./hyprlock)];
}
