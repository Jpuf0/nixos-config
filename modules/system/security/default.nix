{
  security = {
    rtkit.enable = true;
    sudo.enable = true;
    tpm2.enable = true;
    pam.services.hyprlock = {};
    pam.services.hyprland.enableGnomeKeyring = true;
  };
}
