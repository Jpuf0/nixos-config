{
  inputs,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    passwordAuthentication = true;
  };
}
