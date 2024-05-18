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
        ./home
      ]
      ++ lib.concatLists [sharedModules];
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfigurations = {
      "jpuf" = homeManagerConfiguration {
        modules = homeImports."jpuf";
      };
    };
  };
}
