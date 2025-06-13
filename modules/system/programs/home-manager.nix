{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    verbose = true;
    backupFileExtension = "backup";
    sharedModules = [
      {home.stateVersion = lib.mkForce config.system.stateVersion;}
    ];
  };
}
