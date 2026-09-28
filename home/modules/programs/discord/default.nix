{
  pkgs,
  inputs,
  lib,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  self_pkgs = inputs.self.packages.${system};
in {
  imports = [(import ./theme-template.nix)];
  home.packages = with pkgs; [
    vesktop
    self_pkgs.equibop
  ];
}
