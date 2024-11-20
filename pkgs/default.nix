{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      eventsfx = pkgs.callPackage ./eventsfx {};
    };
  };
}
