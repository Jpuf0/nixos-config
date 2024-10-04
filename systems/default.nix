{inputs, ...}: let
  inherit (inputs) self;
  inherit (self) lib;
in {
  noctis = lib.nixosSystem {
    specialArgs = {
      inherit lib inputs self;
    };

    modules = [
      ./noctis
      ../modules

      inputs.home-manager.nixosModules.home-manager
      inputs.catppuccin.nixosModules.catppuccin
      inputs.noshell.nixosModules.default

      {nixpkgs.hostPlatform = "x86_64-linux";}
    ];
  };
}
