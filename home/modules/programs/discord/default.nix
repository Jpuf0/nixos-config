{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [(import ./theme-template.nix)];
  home.packages = with pkgs; [
    # (discord-canary.override {
    #   withVencord = true;
    # })
    vesktop
    # equibop
    (import (pkgs.fetchzip {
      url = "https://github.com/Rexcrazy804/nixpkgs/archive/update-equibop.tar.gz";
      hash = "sha256-Ctx31dXlh5Ze1zSFrsNBEYtf2xVlj0UUAfThnlIG6tE=";
    }) {inherit (pkgs.stdenv.hostPlatform) system;}).equibop
  ];
  # ++ [
  #   inputs.self.packages.${pkgs.system}.equibop
  # ];
}
