{
  pkgs,
  lib,
  ...
}: {
  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    protontricks = {
      enable = true;
    };
  };

  programs.gamemode.enable = true;
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "steam"
  #     "steam-original"
  #     "steam-runtime"
  #   ];
}
