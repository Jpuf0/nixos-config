{inputs, ...}: {
  imports = 
    [(import ./hyprlock.nix)]
    ++ [(import ./config.nix)]
    ++ [inputs.hyprlock.homeManagerModules.hyprlock];
}