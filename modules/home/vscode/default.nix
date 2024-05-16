{
  imports = [
    ./extensions.nix
    ./settings.nix
    ./keybinds.nix
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}