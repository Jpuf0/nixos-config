{
  imports = [
    ./zsh.nix
    ./home-manager.nix
    ./steam.nix
  ];

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
    };
    ssh.startAgent = true;
  };

  virtualisation.docker.enable = true;
}
