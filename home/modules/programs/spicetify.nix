{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # Import spicetify-nix
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  # Configure Spicetify
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;

    # Theme configuration - Catppuccin to match your GTK theme
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    # Popular extensions
    enabledExtensions = with spicePkgs.extensions; [
      shuffle # Better shuffle
      fullAppDisplay # Full app display
      seekSong # Seek through songs
      goToSong # Go to song feature
      betterGenres # Better genre display
      lastfm
      # beautifulLyrics
    ];

    # Custom apps (optional - you can remove these if you don't want them)
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus # Enhanced lyrics
      newReleases # New releases page
      marketplace
    ];

    # Additional settings
    enabledSnippets = with spicePkgs.snippets; [
      pointer # Better pointer/cursor
    ];
  };
}
