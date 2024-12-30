{lib, ...}: {
  programs.home-manager.enable = true;

  home = {
    username = "ypuf";
    homeDirectory = lib.mkDefault "/home/ypuf";
  };
}
