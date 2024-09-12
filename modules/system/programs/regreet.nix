{pkgs, ...}: {
  programs.regreet = {
    enable = false;
    settings = {
      background = "~/.current_wallpaper";
    };
  };
}
