{
  imports = [
    ./zsh.nix
    ./home-manager.nix
  ];

  programs = {
    dconf.enable = true;
  };
}
