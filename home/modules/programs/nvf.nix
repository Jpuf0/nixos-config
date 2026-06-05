{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };
        preventJunkFiles = true;
        undoFile.enable = true;
        enableLuaLoader = true;
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };
        viAlias = true;
        vimAlias = true;

        lsp = {
          enable = true;
          formatOnSave = true;
          trouble.enable = true;
          lspSignature.enable = true;
          lightbulb.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix = {
            enable = true;
            lsp.servers = ["nixd"];
          };
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          json.enable = true;
          lua.enable = true;
          markdown.enable = true;
          python.enable = true;
          rust.enable = true;
          typescript.enable = true;
          typst.enable = true;
          yaml.enable = true;
        };

        notes = {
          todo-comments.enable = true;
        };

        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        autopairs.nvim-autopairs.enable = true;
        autocomplete.nvim-cmp = {
          enable = true;
          sources = {
            buffer = "[Buffer]";
            nvim-cmp = null;
            path = "[Path]";
          };
        };
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        utility = {
          icon-picker.enable = true;
          diffview-nvim.enable = true;
          motion = {
            leap.enable = true;
          };
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          fastaction.enable = true;
        };

        # assistant = {
        #   copilot = {
        #     enable = true;
        #     cmp.enable = true;
        #   };
        # };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };
      };
    };
  };
}
