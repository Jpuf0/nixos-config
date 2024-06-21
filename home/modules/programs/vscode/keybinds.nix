{pkgs, ...}: {
  programs.vscode.keybindings = [
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
}
