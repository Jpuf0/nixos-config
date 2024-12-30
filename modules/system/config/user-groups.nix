{pkgs, ...}: {
  users.users.jpuf = {
    isNormalUser = true;
    description = "i cant have colon 3";
    initialPassword = "nixos";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
      "video"
      "adbusers"
      "plugdev"
    ];
  };

  users.users.ypuf = {
    isNormalUser = true;
    description = "i cant have colon 3";
    initialPassword = "nixos";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "input"
      "video"
      "adbusers"
      "plugdev"
    ];
  };
}
