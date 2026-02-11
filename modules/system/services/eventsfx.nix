{
  inputs,
  pkgs,
  ...
}: {
  systemd.user.services.eventsfx = {
    description = "eventsfx daemon";
    after = ["sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${inputs.eventsfx.packages."${pkgs.stdenv.hostPlatform.system}".default}/bin/eventsfx";
  };
}
