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
      cmake-language-server
      # lemminx
      lua-language-server
      # markdown-oxide
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
      vtsls
      biome
      ty
      ruff
    ];

    plugins = with pkgs.vimPlugins; [
      # {
      #   plugin = none-ls-nvim;
      #   type = "lua";
      #   config = builtins.readFile ./lua/lsp/null-ls.lua;
      # }

      # Misc LSP plugins
      nvim-jdtls

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
          # (builtins.readFile ./lua/lsp/ccls.lua)
          (builtins.readFile ./lua/lsp/bash.lua)
          (builtins.readFile ./lua/lsp/biome.lua)
          (builtins.readFile ./lua/lsp/cmake.lua)
          (builtins.readFile ./lua/lsp/gleam.lua)
          (builtins.readFile ./lua/lsp/html.lua)
          (builtins.readFile ./lua/lsp/luals.lua)
          (builtins.readFile ./lua/lsp/omnisharp.lua)
          (builtins.readFile ./lua/lsp/python.lua)
          (builtins.readFile ./lua/lsp/rust.lua)
          (builtins.readFile ./lua/lsp/sqlls.lua)
          (builtins.readFile ./lua/lsp/vtsls.lua)
        ];
      }

      {
        plugin = blink-cmp;
        type = "lua";
        config = builtins.readFile ./lua/blink.lua;
      }
      friendly-snippets
    ];
  };
}
