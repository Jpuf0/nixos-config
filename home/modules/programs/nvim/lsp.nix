{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      # ccls
      clang-tools
      # cmake-language-server
      lemminx
      lua-language-server
      markdown-oxide
      nil
      nixfmt-rfc-style
      nodePackages.bash-language-server
      nodePackages.prettier
      nodePackages.typescript-language-server
      omnisharp-roslyn
      rust-analyzer
      shellcheck
      shfmt
      sqls
      stylua
      vscode-langservers-extracted
    ];

    plugins = with pkgs.vimPlugins; [
      # Debugging
      {
        plugin = nvim-dap;
        type = "lua";
        config = builtins.readFile ./lua/dap.lua;
      }
      nvim-dap-ui

      # LSP config
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = lib.strings.concatStrings [
          (builtins.readFile ./lua/lsp/bash.lua)
          # (builtins.readFile ./lua/lsp/ccls.lua)
          (builtins.readFile ./lua/lsp/cmake.lua)
          (builtins.readFile ./lua/lsp/html.lua)
          (builtins.readFile ./lua/lsp/luals.lua)
          (builtins.readFile ./lua/lsp/omnisharp.lua)
          (builtins.readFile ./lua/lsp/rust.lua)
          (builtins.readFile ./lua/lsp/sqlls.lua)
          (builtins.readFile ./lua/lsp/tsserver.lua)
        ];
      }
    ];
  };
}
