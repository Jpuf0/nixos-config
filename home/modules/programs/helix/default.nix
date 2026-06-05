{pkgs, ...}: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      ccls
      clang-tools
      # cmake-language-server
      lemminx
      lua-language-server
      markdown-oxide
      nil
      nixfmt
      bash-language-server
      prettier
      typescript-language-server
      omnisharp-roslyn
      rust-analyzer
      shellcheck
      shfmt
      sqls
      stylua
      vscode-langservers-extracted
    ];
    settings = {
      editor = {
        auto-format = false;
        auto-complettion = true;
        bufferline = "always";
        color-modes = true;
        line-number = "relative";
        jump-label-alphabet = "fjdkslaghrueiwoqpvbncmxz"; # Roughly in ease of access order
        end-of-line-diagnostics = "hint";

        shell = [
          "${pkgs.fish}/bin/fish"
          "-c"
        ];

        lsp = {
          auto-signature-help = false;
        };

        statusline = {
          left = [
            "mode"
            "version-control"
            "spinner"
            "workspace-diagnostics"
            "read-only-indicator"
          ];
          center = [];
          right = [
            "selections"
            "register"
            "position"
            "position-percentage"
          ];
          separator = " ";
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
          character = "·";
        };

        gutters = {
          layout = [
            "diff"
            "diagnostics"
            "line-numbers"
            "spacer"
          ];
        };

        file-picker = {
          require-git = false;
          hidden = false; # Will show hidden dirs/files if set to false
        };
      };
    };
  };
}
