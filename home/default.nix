{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    (import ./modules/programs/discord)
    (import ./modules/programs/hypr)
    (import ./modules/programs/scripts)
    # (import ./modules/programs/vscode)
    # (import ./modules/programs/waybar)
    (import ./modules/programs/wofi)
    (import ./modules/programs/bat.nix)
    (import ./modules/programs/btop.nix)
    (import ./modules/programs/direnv.nix)
    (import ./modules/programs/git.nix)
    (import ./modules/programs/lazygit.nix)
    (import ./modules/programs/gtk.nix)
    (import ./modules/programs/kitty.nix)
    # (import ./modules/programs/mako.nix)
    # (import ./modules/programs/dunst.nix)
    # (import ./modules/programs/nvim)
    (import ./modules/programs/nvf.nix)
    (import ./modules/programs/helix)
    (import ./modules/programs/packages.nix)
    (import ./modules/programs/zen)
    (import ./modules/programs/fish)
    # (import ./modules/programs/eventsfx.nix)
    # (import ./modules/programs/claude-desktop.nix)
    (import ./modules/programs/spicetify.nix)
    (import ./modules/programs/xdg.nix)
    (import ./modules/programs/nh.nix)
    # (import ./modules/programs/quickshell)
    # (import ./modules/programs/caelestia)
    (import ./modules/programs/caelestia/caelestia.nix)
    (import ./modules/programs/tailray.nix)
    (import ./modules/programs/aagl.nix)
  ];

  homeImports = {
    "jpuf" =
      [(import ./home.nix)]
      ++ sharedModules;
    "ypuf" =
      [(import ./home_ypuf.nix)]
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
      "ypuf" = homeManagerConfiguration {
        modules = homeImports."ypuf";
        inherit pkgs;
      };
    };
  };
}
