{inputs, ...}: {
  imports =
    [(import ./hyprlock.nix)]
    ++ [(import ./config.nix)];
}
