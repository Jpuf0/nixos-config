{pkgs, ...}: let
  # General Editor Settings
  accessibility = {
    "accessibility.signals.save"."sound" = "userGesture";
  };

  editor = {
    "editor.bracketPairColorization.enabled" = true;
    "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
    "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'SymbolsNerdFont', 'monospace', monospace";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 16;
    "editor.formatOnSave" = true;
    "editor.guides.bracketPairs" = true;
    "editor.guides.indentation" = true;
    "editor.linkedEditing" = true;
    "editor.lineNumbers" = "relative";
    "editor.minimap.enabled" = true;
    "editor.renderControlCharacters" = false;
    "editor.scrollbar.verticalScrollbarSize" = 2;
    "editor.scrollbar.horizontalScrollbarSize" = 2;
    "editor.scrollbar.vertical" = "hidden";
    "editor.scrollbar.horizontal" = "hidden";
    "editor.tabSize" = 2;
    "editor.trimAutoWhitespace" = true;
  };

  files = {
    "files.autoSave" = "onWindowChange";
  };

  terminal = {
    "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'SymbolsNerdFont'";
  };

  window = {
    "window.dialogStyle" = "native";
    "window.titleBarStyle" = "custom";
  };

  workbench = {
    "workbench.colorTheme" = "Catppuccin Mocha";
    "workbench.editor.showTabs" = "multiple";
    "workbench.iconTheme" = "catppuccin-mocha";
    "workbench.panel.defaultLocation" = "bottom";
    "workbench.sideBar.location" = "right";
    "workbench.startupEditor" = "none";
  };

  git = {
    "git.autofetch" = true;
    "git.enableCommitSigning" = true;
    "git.enableSmartCommit" = true;
  };

  # Language Specific
  # Language Formatters
  formatter = {
    "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
    # "[]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  };

  # C/C++
  cpp = {
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

  nix = {
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
    # "nix." = ;
    # "nix." = ;
  };

  typescript = {
    "[typescript]"."editor.codeActionsOnSave"."source.organiseImports" = "explicit";
  };

  typescriptreact = {
    "[typescriptreact]"."editor.codeActionsOnSave"."source.organiseImports" = "explicit";
  };

  python = {
    "python.defaultInterpreterPath" = "${pkgs.python3}/bin/python";
    "python.languageServer" = "Pylance";
    "python.analysis.typeCheckingMode" = "strict";
    "python.analysis.autoFormalStrings" = true;
  };

in {
  programs.vscode.userSettings = {
    "extensions.autoCheckUpdates" = false;
    "extensions.autoUpdate" = false;
    "update.mode" = "none";
  }
  #General Settings
  // accessibility
  // editor
  // files
  // terminal
  // window
  // workbench
  # Git
  // git
  # Language Specific
  // formatter
  // cpp
  // nix
  // typescript
  // typescriptreact
  // python;
}
