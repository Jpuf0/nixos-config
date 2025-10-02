{
  imports = [
    # ./zsh.nix
    ./fish.nix
    ./home-manager.nix
    ./steam.nix
    ./streamdeck.nix
    ./regreet.nix
    ./nix-ld.nix
    ./adb.nix
  ];

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
    };
    ssh.startAgent = true;
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings.features.cdi = true;
  };

  virtualisation.virtualbox.host.enable = true;

  # networking.firewall.trustedInterfaces = ["docker0"];

  hardware.nvidia-container-toolkit.enable = true;
}
