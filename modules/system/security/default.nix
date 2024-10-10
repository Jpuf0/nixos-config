{
  imports = [
    ./sunshine.nix
  ];

  security = {
    rtkit.enable = true;
    sudo.enable = true;
    tpm2.enable = true;
    pam.services.hyprlock = {};
    pam.services.hyprland.enableGnomeKeyring = true;
    pam.loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "memlock";
        value = "unlimited";
      }
      {
        domain = "*";
        type = "soft";
        item = "memlock";
        value = "unlimited";
      }
    ];
  };
}
