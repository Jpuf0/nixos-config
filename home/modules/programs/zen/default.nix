{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with inputs.zen-browser.packages."${pkgs.system}"; [default];
  # home.packages = with inputs.self.packages.${pkgs.system}; [zen-twilight];
}
