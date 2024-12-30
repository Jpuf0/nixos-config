{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      nix-vscode-extensions.overlays.default
      nur.overlay
    ];
  };
}
