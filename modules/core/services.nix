{
  pkgs,
  hostname,
  ...
}: {
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
          username_cmd = "keyring get spotifyd username";
          password_cmd = "keyring get spotifyd password";
          device_name = "noctis";
        };
      };
    };
  };
}
