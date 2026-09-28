{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      app2unit = pkgs.callPackage ./app2unit {};
      amethyst-mod-manager = pkgs.callPackage ./amethyst {};
      eventsfx = pkgs.callPackage ./eventsfx {};
    };
  };
}
