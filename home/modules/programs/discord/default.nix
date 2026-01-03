{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [(import ./theme-template.nix)];
  home.packages = with pkgs; [
    (discord-canary.override {
      withVencord = true;
    })
    vesktop
    # equibop
    (import (pkgs.fetchzip {
      url = "https://github.com/Rexcrazy804/nixpkgs/archive/update-equibop.tar.gz";
      hash = "sha256-QBcO3s4g5OzEWabTrWj/vqFzpAyYYKIrb7slViGbxp0=";
    }) {inherit (pkgs.stdenv.hostPlatform) system;}).equibop
  ];
  # ++ [
  #   inputs.self.packages.${pkgs.system}.equibop
  # ];
}
