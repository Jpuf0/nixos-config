{
  inputs,
  pkgs,
  ...
}: {
  services.ratbagd = {
    enable = true;
  }
}
