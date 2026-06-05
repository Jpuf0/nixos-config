{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with inputs.claude-desktop.packages."${pkgs.stdenv.hostPlatform.system}"; [claude-desktop-with-fhs];
}
