{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      app2unit = pkgs.callPackage ./app2unit {};
      eventsfx = pkgs.callPackage ./eventsfx {};
    };
  };
}
