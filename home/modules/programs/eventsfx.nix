{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with inputs.eventsfx.packages."${pkgs.system}"; [default];
  # home.packages = with inputs.self.packages."${pkgs.system}"; [eventsfx];
}
