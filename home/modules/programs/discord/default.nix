{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) concatLists;
in {
  imports = [(import ./theme-template.nix)];
  home.packages = with pkgs; [
    (vesktop.overrideAttrs (old: {
      patches = concatLists [
        (old.patches or [])
        [./vesktop.patch]
      ];
    }))
    equibop
  ];
}
