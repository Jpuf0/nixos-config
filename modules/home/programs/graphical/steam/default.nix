{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.sakura.programs.steam;
in {
  options.sakura.programs.steam = {
    enable = mkEnableOption "Enable Steam module.";
  };

  config = mkIf cfg.enable {
    programs.gamescope = {
      enable = true;
    };

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libgdiplus
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
          ];
      };

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
