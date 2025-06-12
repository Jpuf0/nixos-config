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
  };
}
