{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./nixpkgs.nix
    ./substitutors.nix
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  system.stateVersion = lib.mkDefault "23.11";
}
