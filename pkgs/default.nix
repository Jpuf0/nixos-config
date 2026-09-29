{self, ...}: {
  systems = ["x86_64-linux"];

  flake.nixosModules.mwb = import ./mwb-linux/module.nix self;

  perSystem = {pkgs, ...}: {
    packages = {
      amethyst-mod-manager = pkgs.callPackage ./amethyst {};
      equibop = pkgs.callPackage ./equibop {};
      eventsfx = pkgs.callPackage ./eventsfx {};
      mwb-linux = pkgs.callPackage ./mwb-linux {};
    };
  };
}
