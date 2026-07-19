{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."hypr/variables.lua".text = ''
    mod = "SUPER"
  '';
}
