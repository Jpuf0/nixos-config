{
  description = "Jpuf's nixos configuration";

  inputs = {
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypr-contrib = {
      url = "github:hyprwm/contrib";
    };

    # hypridle = {
    #   url = "github:hyprwm/Hypridle";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      submodules = true;
    };

    # hyprlock = {
    #   url = "github:hyprwm/Hyprlock";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # nixpkgs = {
    #   url = "github:NixOS/nixpkgs/nixos-23.11";
    # };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./flake];};
}
