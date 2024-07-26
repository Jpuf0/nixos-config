{...}: {
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        deadnix
        git
        nil
        nodePackages.prettier
      ];

      name = "Sakura";
      meta.description = "Just a shell";
    };
    formatter = pkgs.alejandra;
  };
}
