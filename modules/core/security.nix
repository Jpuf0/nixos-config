{...}: {
  security.rtkit.enable = true;
  security.sudo.enable = true;
  security.polkit.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  # security.pam.services.swaylock = {};
}
