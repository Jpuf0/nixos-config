{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    (import ./modules/programs/discord)
    (import ./modules/programs/hypr)
    (import ./modules/programs/scripts)
    (import ./modules/programs/wofi)
    (import ./modules/programs/bat.nix)
    (import ./modules/programs/btop.nix)
    (import ./modules/programs/direnv.nix)
    (import ./modules/programs/git.nix)
    (import ./modules/programs/lazygit.nix)
    (import ./modules/programs/gtk.nix)
    (import ./modules/programs/kitty.nix)
    (import ./modules/programs/nvf.nix)
    (import ./modules/programs/helix)
    (import ./modules/programs/packages.nix)
    (import ./modules/programs/zen)
    (import ./modules/programs/fish)
    (import ./modules/programs/eventsfx.nix)
    (import ./modules/programs/spicetify.nix)
    (import ./modules/programs/xdg.nix)
    (import ./modules/programs/nh.nix)
    (import ./modules/programs/caelestia)
    (import ./modules/programs/tailray.nix)
    (import ./modules/programs/aagl.nix)
    (import ./modules/programs/atuin.nix)
    (import ./modules/programs/gammastep.nix)
    (import ./modules/programs/wayvnc.nix)
  ];

  homeImports = {
    "jpuf" =
      [(import ./home.nix)]
      ++ sharedModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  imports = [
    {_module.args = {inherit homeImports;};}
  ];

  flake = {
    homeConfigurations = {
      "jpuf" = homeManagerConfiguration {
        modules = homeImports."jpuf";
        inherit pkgs;
      };
    };
  };
}
