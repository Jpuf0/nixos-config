{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      amethyst-mod-manager = pkgs.callPackage ./amethyst {};
      equibop = pkgs.callPackage ./equibop {};
      eventsfx = pkgs.callPackage ./eventsfx {};
      mwb-linux = pkgs.callPackage ./mwb-linux {};
    };
  };
}
