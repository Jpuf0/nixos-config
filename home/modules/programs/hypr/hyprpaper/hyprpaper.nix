{inputs, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = true;
      splash_offset = 2.0;

      preload = "/home/jpuf/Pictures/backgrounds/dark-cat-rosewater.png";

      wallpaper = [
        "/home/jpuf/Pictures/backgrounds/dark-cat-rosewater.png"
      ];
    };
  };
}
