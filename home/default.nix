{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    # ./modules/programs/alacritty.nix
    (import ./modules/programs/bat.nix)
    (import ./modules/programs/btop.nix)
    (import ./modules/programs/git.nix)
    (import ./modules/programs/kitty.nix)
    (import ./modules/programs/mako.nix)
    (import ./modules/programs/nvim.nix)
    (import ./modules/programs/zsh.nix)
    (import ./modules/programs/wofi)
    (import ./modules/programs/waybar)
    (import ./modules/programs/vscode)
    (import ./modules/programs/hypr)
    (import ./modules/programs/discord)
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
