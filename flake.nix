{
  description = "Jpuf's nixos configuration";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://cuda-maintainers.cachix.org"
      "https://cache.nixos-cuda.org"
      "https://ezkea.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };

    catppuccin-atuin = {
      url = "github:catppuccin/atuin";
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
      # inputs.nixpkgs.follows = "nixpkgs";
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

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      # url = "github:nixos/nixpkgs/nixpkgs-unstable";
      # url = "github:nixos/nixpkgs/master";
      # url = "github:/nixos/nixpkgs/1284004bf6c6e50d8592b6efe83708931e75aec7";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    eventsfx = {
      url = "github:SaphiraKai/eventsfx";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # quickshell = {
    #   url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #   # url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?rev=f7597cdae2d537c5b12843599955856090dc49d5";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hytale-launcher = {
      url = "github:JPyke3/hytale-launcher-nix";
    };

    millennium = {
      url = "github:SteamClientHomebrew/Millennium/e2c66a276e579ee73c5151b01897bf63503aa12c?dir=packages/nix";
    };

    tailray = {
      url = "github:NotAShelf/tailray";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./flake];};
}
