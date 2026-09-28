{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  eventsfx = inputs.eventsfx.packages."${system}".default;
in
{
  systemd.user.services.eventsfx = {
    description = "eventsfx daemon";
    after = ["sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${eventsfx}/bin/eventsfx";
  };
}
