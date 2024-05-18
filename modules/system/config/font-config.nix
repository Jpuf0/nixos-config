{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;

      antialias = true;

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji" "Symbols Nerd Font"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Inter" "Noto Color Emoji"];
      };

      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };

      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
    };

    fontDir = {
      enable = true;
    };

    packages = with pkgs; [
      nerdfonts
      (nerdfonts.override {fonts = ["JetBrainsMono" "NerdFontsSymbolsOnly"];})
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      twemoji-color-font

      (google-fonts.override {fonts = ["Inter"];})
    ];
  };
}
