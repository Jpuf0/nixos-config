{pkgs, ...}: {
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    udev.packages = with pkgs; [
      via
      vial
    ];
    spotifyd = {
      enable = true;
      settings = {
        global = {
          username = "jasper_puffett";
          use_keyring = true;
        };
      };
    };
  };
}
