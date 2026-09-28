{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  eventsfx = inputs.eventsfx.packages."${system}".default;
in
{
  home.packages = [eventsfx];
}
