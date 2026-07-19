{
  pkgs,
  config,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = [
    # pkgs.nerd-fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.twemoji-color-font
    pkgs.noto-fonts-color-emoji
  ];

  gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    theme = {
      name = "catppuccin-mocha-lavender-compact"; # Fixed: was "Catppuccin-Mocha-Compact-Lavender-Dark"
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha";
        accents = ["lavender"];
        size = "compact";
        # tweaks = [ "rimless" ];
      };
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
      size = 22;
    };

    gtk2 = {
      extraConfig = "gtk-application-prefer-dark-theme = true";
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
      theme = config.gtk.theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "gtk2";
  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "catppuccin-mocha-lavender-compact";
        icon-theme = "Papirus-Dark";
        cursor-theme = "Nordzy-cursors";
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
    size = 22;
  };
}
