{
  systems = ["x86_64-linux"];

  imports = [
    ./zen-unstable
  ];

  perSystem = {pkgs, ...}: {
    packages = {
      app2unit = pkgs.callPackage ./app2unit {};
      eventsfx = pkgs.callPackage ./eventsfx {};
      equibop = pkgs.callPackage ./equibop {
        sourceFiles = "/home/jpuf/Equibop";
      };
    };
  };
}
