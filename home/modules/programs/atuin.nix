{inputs, ...}: {
  programs.atuin = {
    enable = true;

    settings = {
      auto_sync = true;
      update_check = false;
      sync_address = "http://192.168.1.144:8888/";
      sync_frequency = "5m";
      search_mode = "daemon-fuzzy";
      enter_accept = true;

      sync = {
        records = true;
      };

      daemon = {
        enabled = true;
        autostart = false;
        sync_frequency = 300;
      };

      theme = {
        theme = "catppuccin-mocha-lavender";
      };

      ai = {
        enabled = true;
        endpoint = "http://localhost:8080";
        endpoint_protocol = "oss";
        api_token = "ollama";
      };
    };

    enableFishIntegration = true;

    flags = [
      "--disable-up-arrow"
    ];
    themes = {
      catppuccin-mocha-lavender = "${inputs.catppuccin-atuin}/themes/mocha-lavender.toml";
    };
  };
}
