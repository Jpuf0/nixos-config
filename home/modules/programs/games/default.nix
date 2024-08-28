{inputs, ...}: {
  imports =
    [(import ./moonlight.nix)]
    ++ [(import ./sunshine.nix)];
}
