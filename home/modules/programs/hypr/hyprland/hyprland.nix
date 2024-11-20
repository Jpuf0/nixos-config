{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swww
    # swaybg
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
    wofi
    grim
    slurp
    wl-clipboard
    cliphist
    # wf-recorder
    # libinput
    glib
    wayland
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    systemd.enable = true;
  };
}
