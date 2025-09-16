{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  cli-default = inputs.caelestia-cli.packages.${system}.default;
  shell-default = inputs.caelestia-shell.packages.${system}.with-cli;
in {
  home.packages = [
    cli-default
    shell-default
  ];

  systemd.user.services.caelestia = {
    Unit = {
      Description = "Caelestia Shell Service";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
      X-Restart-Triggers = ["${config.xdg.configHome}/caelestia/shell.json"];
    };
    Service = {
      Type = "exec";
      ExecStart = "${shell-default}/bin/caelestia-shell";
      Restart = "on-failure";
      RestartSec = "5s";
      TimeoutStopSec = "5s";
      Environment = ["QT_QPA_PLATFORM=wayland"];
      Slice = "session.slice";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
