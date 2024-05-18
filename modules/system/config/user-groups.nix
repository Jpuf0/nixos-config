{pkgs, ...}: {
  users.users.jpuf = {
    isNormalUser = true;
    description = ":3";
    initialPassword = "nixos";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
