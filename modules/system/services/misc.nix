{pkgs, ...}: {
  services = {
    gnome.gnome-keyring.enable = true;
    udev = {
      enable = true;
      packages = with pkgs; [
        via
        vial
      ];
    };
    usbmuxd.enable = true;
    avahi = {
      enable = true;
      settings = {
        publish = {
          "disable-publishing" = false;
          disable-user-service-publishing = false;
          publish-addresses = true;
        };
      };
    };
  };
}
