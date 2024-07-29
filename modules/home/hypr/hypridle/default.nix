{inputs, ...}: {
  imports = [
    # inputs.hypridle.homeManagerModules.default
    (import ./hypridle.nix)
  ];
}
