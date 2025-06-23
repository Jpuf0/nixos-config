{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;
  };
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
  };
}
