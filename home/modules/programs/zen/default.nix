{
  pkgs,
  inputs,
  ...
}: let
  upstream = "${inputs.caelestia-dots}/zen";
in {
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;
    profiles.default.userChrome = builtins.readFile "${upstream}/userChrome.css";
  };
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
  };
}
