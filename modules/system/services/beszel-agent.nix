{config, ...}: {
  services.beszel.agent = {
    enable = true;
    smartmon = {
      enable = true;
    };
    openFirewall = true;
    environmentFile = "${config.home-manager.users."jpuf".xdg.configHome}/beszel/beszel-agent.env";
  };
}
