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
        [
          ./ghost
        ]
        ++ commonModules
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
        [
          ./noctis
        ]
        ++ commonModules
        ++ [
          {
            home-manager = {
              users.jpuf.imports = homeImports."jpuf";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
    };

    azalea = nixosSystem {
      inherit specialArgs;

      modules = [
          ./azalea
        ]
        ++ commonModules
        ++ [
          {
            home-manager = {
              users.ypuf.imports = homeImports."ypuf";
              extraSpecialArgs = specialArgs;
            };
          }
        ];
    };
  };
}
