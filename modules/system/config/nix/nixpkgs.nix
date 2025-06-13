{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      # (import ./overlays.nix)
      nix-vscode-extensions.overlays.default
      nur.overlays.default
      nix-alien.overlays.default
    ];
  };
}
