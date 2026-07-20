{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;

      antialias = true;

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji" "Symbols Nerd Font"];
        serif = ["Noto Serif" "Inter" "Noto Color Emoji"];
        sansSerif = ["Noto Sans" "Inter" "Noto Color Emoji"];
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
      inter
      noto-fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.caskaydia-cove
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      twemoji-color-font
    ];
  };
}
