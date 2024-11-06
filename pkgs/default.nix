{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      effectsfx = pkgs.callPackage ./eventnsfx {};
    };
  };
}
