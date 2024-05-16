{
  inputs,
  pkgs,
  ...
}: let 
  code-extensions = inputs.nix-vscode-extensions.extensions.${pkgs.system}; 

in {
  programs.vscode = {
    extensions = with code-extensions.vscode-marketplace; [
      # nix language
      bbenoist.nix
      # nix-shell suport
      arrterian.nix-env-selector
      # nix formatter
      jnoortheen.nix-ide
      # python
      ms-python.python
      # C/C++
      ms-vscode.cpptools
      # OCaml
      ocamllabs.ocaml-platform
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


      # Color theme
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];
  };
}