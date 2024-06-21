{
  homeImports,
  inputs,
  self,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  modules = "${self}/modules/system";
  hardware = modules + "/hardware";

  commonModules = [
    "${modules}/config"
    "${modules}/programs"
    "${modules}/security"
    "${modules}/services"
    "${hardware}/bluetooth.nix"
    "${hardware}/intel.nix"
    "${hardware}/nvidia.nix"
  ];

  specialArgs = {inherit inputs self;};
in {
  flake.nixosConfigurations = {
    ghost = nixosSystem {
      inherit specialArgs;

      modules =
        commonModules
        ++ [./ghost]
        ++ [
          {
            home-manager = {
              users.jpuf.imports = homeImports."jpuf";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
    };

    noctis = nixosSystem {
      inherit specialArgs;

      modules =
        commonModules
        ++ [./noctis];
    };
  };
}
