{
  inputs,
  pkgs,
  ...
}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };
}
