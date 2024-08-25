{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    (import ./modules/programs/discord)
    (import ./modules/programs/floorp)
    (import ./modules/programs/hypr)
    (import ./modules/programs/scripts)
    (import ./modules/programs/vscode)
    (import ./modules/programs/waybar)
    (import ./modules/programs/wofi)
    (import ./modules/programs/bat.nix)
    (import ./modules/programs/btop.nix)
    (import ./modules/programs/direnv.nix)
    (import ./modules/programs/git.nix)
    (import ./modules/programs/gtk.nix)
    (import ./modules/programs/kitty.nix)
    (import ./modules/programs/mako.nix)
    # (import ./modules/programs/nix-ld.nix)
    (import ./modules/programs/nvim.nix)
    (import ./modules/programs/packages.nix)
    (import ./modules/programs/zsh.nix)
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
