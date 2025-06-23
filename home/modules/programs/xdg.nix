{
  pkgs,
  config,
  ...
}: {
  xdg = {
    enable = true;
    configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = "Catppuccin-Mocha-Lavender";
      };
      "Kvantum/Catppuccin-Mocha-Lavender".source = "${
        (pkgs.catppuccin-kvantum.override {
          accent = "lavender";
          variant = "mocha";
        })
      }/share/kvantum/Catppuccin-Mocha-Lavender";
    };
    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/uri-list" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/chrome" = "zen-beta.desktop";
        "text/html" = "zen-beta.desktop";
        "application/x-extension-htm" = "zen-beta.desktop";
        "application/x-extension-html" = "zen-beta.desktop";
        "application/x-extension-shtml" = "zen-beta.desktop";
        "application/xhtml+xml" = "zen-beta.desktop";
        "application/x-extension-xhtml" = "zen-beta.desktop";
        "application/x-extension-xht" = "zen-beta.desktop";
        "x-scheme-handler/about" = "zen-beta.desktop";
        "x-scheme-handler/unknown" = "zen-beta.desktop";

        "image/jpeg" = "imv.desktop";
        "image/gif" = "imv.desktop";
      };
    };
  };
}
