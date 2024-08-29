{pkgs, ...}: {
  programs.regreet = {
    enable = true;
    settings = {
      background = "~/.current_wallpaper";
    };
  };
}
