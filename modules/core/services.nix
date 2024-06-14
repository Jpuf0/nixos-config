{pkgs, ...}: {
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    udev.packages = with pkgs; [
      via
      vial
    ];
  };
}
