{pkgs, ...}: {
  imports = [
    ./options.nix
    ./plugins.nix
    ./telescope.nix
    ./lsp.nix
    ./ftplugin.nix
    ./theme.nix
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = builtins.readFile (./lua/keybinds.lua);
  };
}
