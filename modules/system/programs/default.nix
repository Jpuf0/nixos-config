{
  imports = [
    ./zsh.nix
    ./home-manager.nix
    ./steam.nix
    ./streamdeck.nix
    ./regreet.nix
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
