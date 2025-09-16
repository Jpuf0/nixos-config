{
  config,
  lib,
  ...
}: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    openFirewall = false;
    host = "0.0.0.0";
    user = "ollama";
    group = "llm";
  };

  systemd.services.ollama.serviceConfig = let
    cfg = config.services.ollama;
    staticUser = cfg.user != null && cfg.group != null;
  in {
    DynamicUser = lib.mkForce (!staticUser);
    UMask = lib.mkForce "0007";
    StateDirectory = ["ollama/models"];
  };
}
