{pkgs, ...}: {
  imports = [
    ./eventsfx.nix
    ./kde/polkit-kde.nix
    ./misc.nix
    ./mpris-proxy.nix
    ./mullvad.nix
    ./networking.nix
    ./ollama.nix
    ./pipewire.nix
    ./wayland.nix
    ./ssh.nix
  ];

  services = {
    accounts-daemon.enable = true;
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    tumbler.enable = true;
    fwupd.enable = true;
    flatpak.enable = true;

    dbus = {
      enable = true;
      implementation = "broker";
      packages = with pkgs; [dconf gcr udisks2];
    };
  };
}
