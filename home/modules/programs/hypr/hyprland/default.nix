{
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./variables.nix
  ];

  home.packages = [
    inputs.hypr-contrib.packages.${system}.grimblast
  ];

  xdg.configFile = let
    lua = [
      ./config/animations.lua
      ./config/binds.lua
      ./config/hyprland.lua
      ./config/rules.lua
      ./config/settings.lua
    ];
  in
    builtins.listToAttrs (
      map (e: {
        name = "hypr/${lib.baseNameOf e}";
        value = {
          source = e;
        };
      })
      lua
    );
}
