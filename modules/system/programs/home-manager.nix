{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.nix-ld.nixosModules.nix-ld
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    sharedModules = [
      {home.stateVersion = lib.mkForce config.system.stateVersion;}
    ];
  };
}
