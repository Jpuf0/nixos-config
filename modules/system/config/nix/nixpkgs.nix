{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      # (import ./overlays.nix)
      nix-vscode-extensions.overlays.default
      nur.overlays.default
      nix-alien.overlays.default
      millennium.overlays.default
      (_: prev: {
        openldap = prev.openldap.overrideAttrs {
          doCheck = !prev.stdenv.hostPlatform.isi686;
        };
      })
    ];
  };
}
