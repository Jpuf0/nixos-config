{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with inputs.eventsfx.packages."${pkgs.system}"; [default];
}
