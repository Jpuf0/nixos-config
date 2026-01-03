{
  config,
  lib,
  pkgs,
  ...
}: {
  services.zerotierone = {
    enable = true;
    joinNetworks = ["633e31d8a2d54630"];
  };
}
