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
    enable = true;
    mime.enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/uri-list" = cfg.default_browser;
        "x-scheme-handler/http" = cfg.default_browser;
        "x-scheme-handler/https" = cfg.default_browser;
        "x-scheme-handler/chrome" = cfg.default_browser;
        "text/html" = cfg.default_browser;
        "application/x-extension-htm" = cfg.default_browser;
        "application/x-extension-html" = cfg.default_browser;
        "application/x-extension-shtml" = cfg.default_browser;
        "application/xhtml+xml" = cfg.default_browser;
        "application/x-extension-xhtml" = cfg.default_browser;
        "application/x-extension-xht" = cfg.default_browser;
        "x-scheme-handler/about" = cfg.default_browser;
        "x-scheme-handler/unknown" = cfg.default_browser;
      };
    };
  };
}
