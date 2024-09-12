{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      # bun
      oven.bun-vscode
      # nix language
      bbenoist.nix
      # nix-shell suport
      arrterian.nix-env-selector
      # nix formatter
      jnoortheen.nix-ide
      # python
      ms-python.python
      # C/C++
      # ms-vscode.cpptools

      # C# Devkit
      ms-dotnettools.csdevkit
      # Discord Presence
      leonardssh.vscord
      # Comment Anchors
      exodiusstudios.comment-anchors
      # TailwindCSS
      bradlc.vscode-tailwindcss
      # CSS Variables
      vunguyentuan.vscode-css-variables
      # PostCSS
      vunguyentuan.vscode-postcss
      # Liveserver
      ritwickdey.liveserver
      # Prettier
      esbenp.prettier-vscode
      # Typescript Error Translator
      mattpocock.ts-error-translator
      # Prisma
      prisma.prisma
      # Editor Config
      editorconfig.editorconfig
      # GitHub Readme Preview
      bierner.markdown-preview-github-styles
      bierner.github-markdown-preview
      # Color theme
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      # Gleam
      gleam.gleam
      # Continue.dev
      continue.continue
      # SuperMaven
      supermaven.supermaven

      # External Extensions from [nix4vscode](https://github.com/nix-community/nix4vscode)
      # Continue.dev use local llm for code
      # plugins.continue.continue
      # SuperMaven Github Copilor but better??
      # plugins.supermaven.supermaven
    ];
  };
}
