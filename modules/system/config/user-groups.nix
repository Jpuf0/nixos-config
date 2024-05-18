{pkgs, ...}: {
  users.users.jpuf = {
    isNormalUser = true;
    description = "i cant have colon 3";
    initialPassword = "nixos";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
