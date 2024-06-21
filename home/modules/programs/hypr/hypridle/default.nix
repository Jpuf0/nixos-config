{inputs, ...}: {
  imports = [
    inputs.hypridle.homeManagerModules.hypridle
    (import ./hypridle.nix)
  ];
}
