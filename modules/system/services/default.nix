{pkgs, ...}: {
  imports = [
    ./kde/polkit-kde.nix
    ./networking
    ./pipewire
  ];

  services = {
    accounts-daemon.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    tumbler.enable = true;

    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [dconf gcr udisks2];
    };
  };
}
