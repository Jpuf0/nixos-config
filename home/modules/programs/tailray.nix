{
  inputs,
  ...
}: {
  imports = [inputs.tailray.homeModules.default];

  services.tailray = {
    enable = true;
    theme = "dark";
  };
}
