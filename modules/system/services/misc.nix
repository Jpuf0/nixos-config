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
  };
}
