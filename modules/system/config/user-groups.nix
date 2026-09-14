{pkgs, ...}: {
  users.users.jpuf = {
    isNormalUser = true;
    description = "jpuf";
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
      "llm"
    ];
  };

  users.users.ypuf = {
    isNormalUser = true;
    description = "ypuf";
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
    ];
  };
}
