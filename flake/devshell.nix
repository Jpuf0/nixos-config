{...}: {
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        # Nix tooling
        nil # LSP
        statix # static checker
        deadnix # dead code finder

        git
        nix-prefetch

        # Formatters
        alejandra
      ];

      name = "Sakura";
      meta.description = "Just a shell";
    };
    formatter = pkgs.alejandra;
  };
}
