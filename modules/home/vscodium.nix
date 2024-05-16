{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
      # nix language
      bbenoist.nix
      # nix-shell suport
      arrterian.nix-env-selector
      # python
      ms-python.python
      # C/C++
      ms-vscode.cpptools
      # OCaml
      ocamllabs.ocaml-platform

      # Discord Presence
      # leonardssh.vscord

      # Comment Anchors
      # exodiusstudios.comment-anchors
      # TailwindCSS
      bradlc.vscode-tailwindcss
      # CSS Variables
      # vunguyentuan.vscode-css-variables
      # PostCSS
      # vunguyentuan.vscode-postcss
      # Liveserver
      ritwickdey.liveserver
      # Prettier
      esbenp.prettier-vscode
      # Typescript Error Translator
      mattpocock.ts-error-translator
      # Prisma
      prisma.prisma

      # Color theme
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];
    userSettings = {
      "update.mode" = "none";
      "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update
      "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509

      "git.enableSmartCommit" = true;

      "accessibility.signals.save" = {
        "sound"= "userGesture";
      };

      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.codeActionsOnSave" = {
          "source.organiseImports" = "explicit";
        };
        "editor.formatOnSave" = true;
      };

      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.codeActionsOnSave" = {
          "source.organiseImports" = "explicit";
        };
        "editor.formatOnSave" = true;
      };

      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'SymbolsNerdFont', 'monospace', monospace";
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'SymbolsNerdFont'";
      "editor.fontSize" = 16;
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "vsicons.dontShowNewVersionMessage" = true;
      "explorer.confirmDragAndDrop" = false;
      "editor.fontLigatures" = true;
      "editor.minimap.enabled" = false;
      "workbench.startupEditor" = "none";

      "workbench.layoutControl.type" = "menu";
      "workbench.editor.limit.enabled" = true;
      "workbench.editor.limit.value" = 5;
      "workbench.editor.limit.perEditorGroup" = true;
      "workbench.editor.showTabs" = "single";
      "files.autoSave" = "onWindowChange";
      "explorer.openEditors.visible" = 0;
      "breadcrumbs.enabled" = false;
      "editor.renderControlCharacters" = false;
      "editor.scrollbar.verticalScrollbarSize" = 2;
      "editor.scrollbar.horizontalScrollbarSize" = 2;
      "editor.scrollbar.vertical" = "hidden";
      "editor.scrollbar.horizontal" = "hidden";
      "workbench.layoutControl.enabled" = false;

      "editor.mouseWheelZoom" = true;

      "C_Cpp.intelliSenseUpdateDelay" = 500;
      "C_Cpp.codeAnalysis.updateDelay" = 500;
      "C_Cpp.autocompleteAddParentheses" = true;
      "C_Cpp.formatting" = "vcFormat";
      "C_Cpp.vcFormat.newLine.beforeOpenBrace.block" = "sameLine";
      "C_Cpp.vcFormat.newLine.beforeOpenBrace.function" = "sameLine";
      "C_Cpp.vcFormat.newLine.beforeOpenBrace.lambda" = "sameLine";
      "C_Cpp.vcFormat.newLine.beforeOpenBrace.namespace" = "sameLine";
      "C_Cpp.vcFormat.newLine.beforeOpenBrace.type" = "sameLine";
      "C_Cpp.vcFormat.space.pointerReferenceAlignment" = "right";
      "C_Cpp.vcFormat.newLine.beforeElse" = false;
      "C_Cpp.vcFormat.newLine.beforeCatch" = false;
      "C_Cpp.vcFormat.indent.caseLabels" = true;
      "C_Cpp.clang_format_fallbackStyle" = "{ BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 0}";
    };
    # Keybindings
    keybindings = [
      {
        key = "ctrl+q";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+s";
        command = "workbench.action.files.saveFiles";
      }
    ];
  };
}
