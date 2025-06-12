{pkgs, ...}: {
  users.users.jpuf = {
    isNormalUser = true;
    description = "i cant have colon 3";
    initialPassword = "nixos";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
      "video"
      "adbusers"
      "plugdev"
      "vboxusers"
    ];
  };
}
