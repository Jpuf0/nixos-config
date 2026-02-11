{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with inputs.eventsfx.packages."${pkgs.stdenv.hostPlatform.system}"; [default];
}
