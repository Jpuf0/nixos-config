{
  config,
  pkgs,
  ...
}: {
  programs.nh = {
    enable = true;
    flake = "/home/jpuf/.nixos";
  };
}
