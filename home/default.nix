{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    ./modules/programs/alacritty.nix
    ./modules/programs/bat.nix
    ./modules/programs/btop.nix
    ./modules/programs/git.nix
    ./modules/programs/kitty.nix
    ./modules/programs/mako.nix
    ./modules/programs/nvim.nix
    ./modules/programs/swaylock.nix
    ./modules/programs/zsh.nix
    ./modules/programs/wofi
    ./modules/programs/waybar
    ./modules/programs/vscode
    ./modules/programs/hypr
    ./modules/programs/discord
  ];

  homeImports = {
    "jpuf" =
      [
        ./home.nix
      ]
      ++ lib.concatLists [sharedModules];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "jpuf" = homeManagerConfiguration {
        inherit pkgs;
        modules = homeImports."jpuf";
      };
    };
  };
}
