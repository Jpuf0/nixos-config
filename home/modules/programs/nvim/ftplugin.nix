{
  pkgs,
  lib,
  config,
  ...
}: {
  home.file."${config.xdg.configHome}/nvim/ftplugin/nix.lua".source = ./lua/ftplugin/nix.lua;
  home.file."${config.xdg.configHome}/nvim/ftplugin/text.lua".source = ./lua/ftplugin/text.lua;
  home.file."${config.xdg.configHome}/nvim/ftplugin/markdown.lua".source = ./lua/ftplugin/text.lua;
  home.file."${config.xdg.configHome}/nvim/ftplugin/typescriptreact.lua".source = ./lua/ftplugin/typescriptreact.lua;
  home.file."${config.xdg.configHome}/nvim/ftplugin/typescript.lua".source = ./lua/ftplugin/typescriptreact.lua;
  home.file."${config.xdg.configHome}/nvim/ftplugin/javascript.lua".source = ./lua/ftplugin/typescriptreact.lua;
}
