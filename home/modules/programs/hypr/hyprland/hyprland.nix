{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.stdenv.hostPlatform.system}.grimblast
    wofi
    wl-clipboard
    cliphist
    glib
    swaybg
    awww
    mpvpaper
    psmisc
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    xwayland = {
      enable = true;
      # hidpi = true;
    };
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
