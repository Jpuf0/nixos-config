{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./nixpkgs.nix
    ./substituters.nix
  ];

  environment.systemPackages = with pkgs; [
    git
  ];

  nix = {
    settings = {
      auto-optimise-store = false;
      experimental-features = ["nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      dates = "*-*-1/2";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };
  };
  system.stateVersion = lib.mkDefault "23.11";
}
