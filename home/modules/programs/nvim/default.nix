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
    withRuby = true;
    withPython3 = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    initLua = builtins.readFile (./lua/keybinds.lua);
  };
}
