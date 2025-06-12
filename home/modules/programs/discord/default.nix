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
    equibop
  ];
  # ++ [
  #   inputs.self.packages.${pkgs.system}.equibop
  # ];
}
