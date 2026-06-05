{
  config,
  lib,
  pkgs,
  ...
}: {
  services.llama-swap = {
    enable = true;
    port = 11343;
    openFirewall = false;
  };

  services.llama-cpp = {
    enable = true;
    port = 11344;
  };
}
