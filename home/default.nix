{
  inputs,
  lib,
  ...
}: let
  sharedModules = [
    ./modules/programs/zsh.nix
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
