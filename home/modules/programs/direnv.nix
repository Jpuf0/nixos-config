{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    silent = true;
    nix-direnv = {
      enable = true;
      package = pkgs.lixPackageSets.stable.nix-direnv;
    };
  };
}
