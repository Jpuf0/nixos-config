{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      # (import ./overlays.nix)
      nur.overlays.default
      nix-alien.overlays.default
      millennium.overlays.default
      # claude-code.overlays.default
      claude-desktop.overlays.default

      # Only uncomment if using nixpkgs-unstable.
      # llm-agents.overlays.shared-nixpkgs
    ];
  };
}
