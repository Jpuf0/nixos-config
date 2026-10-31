{pkgs, ...}: {
  home.packages = with pkgs; [
    wayvnc
  ];

  services.wayvnc = {
    enable = true;
    autoStart = true;
    settings = {
      address = "0.0.0.0";
      port = 5900;
    };
  };

  # systemd.user.services.wayvnc = {
  #   Unit = {
  #     Description = "Wayvnc server for UWSM-managed Hyprland";
  #     # Binds cleanly to UWSM's custom session lifecycle
  #     After = ["wayland-session.target"];
  #     PartOf = ["wayland-session.target"];
  #   };
  #   Service = {
  #     # Use uwsm app -- to wrapper the binary inside its own systemd scope/slice
  #     ExecStart = "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.wayvnc}/bin/wayvnc 0.0.0.0 5900";
  #     Restart = "on-failure";
  #   };
  #   Install = {
  #     WantedBy = ["wayland-session.target"];
  #   };
  # };
}
