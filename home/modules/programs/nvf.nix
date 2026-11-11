{
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.strings) toUpper;

  # Keymap helpers so the Zed-style bindings below stay readable.
  kbmap = mode: key: action: desc: {inherit mode key action desc;};
  luaMap = mode: key: action: desc: {
    inherit mode key action desc;
    lua = true;
  };
  # Remapping (non-noremap) variant, used to reuse builtin/plugin mappings like `gcc`.
  remap = mode: key: action: desc: {
    inherit mode key action desc;
    noremap = false;
  };

  # With the kitty keyboard protocol Ctrl+Shift+<letter> can arrive as either
  # case, so bind both spellings.
  ctrlShift = mode: letter: action: desc: [
    (kbmap mode "<C-S-${letter}>" action desc)
    (kbmap mode "<C-S-${toUpper letter}>" action desc)
  ];

  telescope = picker: "<cmd>Telescope ${picker}<CR>";
in {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        # ── Editor behaviour (mirrors ~/.config/zed/settings.json) ──────────
        options = {
          # Zed: "hard_tabs": false, "tab_size": 4 (Nix overridden to 2 below)
          expandtab = true;
          tabstop = 4;
          shiftwidth = 4;
          softtabstop = 4;

          # Zed: "vertical_scroll_margin": 3, "horizontal_scroll_margin": 5
          scrolloff = 3;
          sidescrolloff = 5;

          # Zed: "soft_wrap": "none"
          wrap = false;

          # Zed: "pane_split_direction_vertical": "right" / "horizontal": "down"
          splitright = true;
          splitbelow = true;

          # Always reserve the gutter so git/diagnostic signs don't shift text.
          signcolumn = "yes";
          mouse = "a";
          # One status bar for the whole window, like Zed's.
          laststatus = 3;
          showmode = false;
          # Quicker CursorHold -> diagnostics float and git blame.
          updatetime = 300;

          # What gets stored in per-project sessions.
          sessionoptions = "buffers,curdir,folds,tabpages,winsize,winpos,localoptions";
        };

        # Zed: "relative_line_numbers": "enabled", "use_smartcase_search": true
        lineNumberMode = "relNumber";
        searchCase = "smart";

        # Neo-tree handles directories instead of netrw (see the VimEnter hook below).
        globals = {
          loaded_netrw = 1;
          loaded_netrwPlugin = 1;
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

        autocmds = [
          # {
          #   enable    = true;  # bool
          #   event     = null;  # nullOr (listOf str)   [ "BufWritePre" ]
          #   pattern   = null;  # nullOr (listOf str)   [ "*.lua", "*.nix" ]
          #   callback  = null;  # nullOr luaInline      lib.generators.mkLuaInline "function() print('File saved!) end"
          #   command   = null;  # nullOr str            "echo 'File saved!'"
          #   group     = null;  # nullOr str            "MyCustomAuGroup"
          #   desc      = null;  # nullOr str            "Format buffer on save"
          #   once      = false; # bool
          #   nested    = false; # bool
          # }
          {
            enable = true;
            event = ["CursorHold"];
            callback = mkLuaInline ''
              function()
                vim.diagnostic.open_float(nil, {
                  focusable = false,
                  close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                  border = "rounded",
                  source = true,
                  scope = "cursor",
                })
              end
            '';
            desc = "Show diagnostics under the cursor";
          }

          # Zed: "languages": { "Nix": { "tab_size": 2 } }
          {
            enable = true;
            event = ["FileType"];
            pattern = ["nix" "yaml" "json" "jsonc"];
            callback = mkLuaInline ''
              function()
                vim.bo.tabstop = 2
                vim.bo.shiftwidth = 2
                vim.bo.softtabstop = 2
              end
            '';
            desc = "2-space indent for Nix/YAML/JSON";
          }

          # Zed opens a folder as a project: `nvim .` (or `nvim some/dir`) cds into
          # it and restores that folder's last session, or shows the project panel
          # if there isn't one yet. Plain `nvim` is handled by session-manager itself.
          {
            enable = true;
            event = ["VimEnter"];
            nested = true;
            callback = mkLuaInline ''
              function()
                if vim.fn.argc() ~= 1 or vim.g.started_with_stdin then
                  return
                end
                local dir = vim.fn.argv(0)
                if vim.fn.isdirectory(dir) ~= 1 then
                  return
                end

                local dir_buf = vim.api.nvim_get_current_buf()
                vim.cmd.cd(vim.fn.fnameescape(dir))
                vim.cmd("silent! %argdelete")
                vim.cmd.enew()
                pcall(vim.api.nvim_buf_delete, dir_buf, { force = true })

                local ok, sm = pcall(require, "session_manager")
                if not (ok and sm.load_current_dir_session(true)) then
                  vim.cmd("Neotree show left")
                end
              end
            '';
            desc = "Open a directory as a project (Zed-style)";
          }

          # Tell kitty when Neovim is focused, so kitty's own Ctrl+Shift shortcuts
          # are passed through to the editor (see `--when-focus-on var:in_editor`
          # in kitty.nix).
          {
            enable = true;
            event = ["VimEnter" "VimResume" "UIEnter"];
            callback = mkLuaInline ''
              function()
                if vim.env.KITTY_WINDOW_ID then
                  io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQ==\007")
                end
              end
            '';
            desc = "Set kitty in_editor user var";
          }
          {
            enable = true;
            event = ["VimLeave" "VimSuspend"];
            callback = mkLuaInline ''
              function()
                if vim.env.KITTY_WINDOW_ID then
                  io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
                end
              end
            '';
            desc = "Unset kitty in_editor user var";
          }
        ];

        # ── Zed keybindings (from ~/.config/zed/keymap.json, VS Code base) ──
        # Vim's own keys are kept; these are layered on top.
        keymaps = lib.flatten [
          # Files, search and pickers
          (kbmap "n" "<C-p>" (telescope "find_files") "Find file (Zed: file_finder)")
          (kbmap "n" "<C-e>" (telescope "find_files") "Find file (Zed: file_finder)")
          (ctrlShift "n" "p" (telescope "commands") "Command palette")
          (kbmap "n" "<F1>" (telescope "commands") "Command palette")
          (ctrlShift "n" "f" (telescope "live_grep") "Search project")
          (ctrlShift "v" "f" (telescope "grep_string") "Search project for selection")
          (ctrlShift "n" "h" "<cmd>GrugFar<CR>" "Search & replace in project")
          (kbmap "n" "<C-t>" (telescope "lsp_dynamic_workspace_symbols") "Project symbols")
          (ctrlShift "n" "o" (telescope "lsp_document_symbols") "Outline (symbols in file)")
          (kbmap "n" "<C-Tab>" (telescope "buffers sort_mru=true ignore_current_buffer=true") "Tab switcher")
          (kbmap "n" "<C-A-o>" "<cmd>SessionManager load_session<CR>" "Open recent project")

          # Panels / docks
          (kbmap "n" "<C-b>" "<cmd>Neotree toggle left<CR>" "Toggle project panel")
          (ctrlShift "n" "e" "<cmd>Neotree focus reveal left<CR>" "Focus project panel")
          (ctrlShift "n" "b" "<cmd>AerialToggle<CR>" "Toggle outline panel")
          (ctrlShift "n" "m" "<cmd>Trouble diagnostics toggle<CR>" "Project diagnostics")
          (kbmap "n" "<C-j>" "<cmd>ToggleTerm<CR>" "Toggle bottom dock (terminal)")

          # Files & panes
          (kbmap ["n" "i" "v"] "<C-s>" "<cmd>write<CR>" "Save")
          (kbmap "n" "<C-n>" "<cmd>enew<CR>" "New file")
          (kbmap "n" "<C-\\>" "<cmd>vsplit<CR>" "Split right")
          (kbmap "n" "<C-k><C-Left>" "<cmd>wincmd h<CR>" "Pane left")
          (kbmap "n" "<C-k><C-Right>" "<cmd>wincmd l<CR>" "Pane right")
          (kbmap "n" "<C-k><C-Up>" "<cmd>wincmd k<CR>" "Pane up")
          (kbmap "n" "<C-k><C-Down>" "<cmd>wincmd j<CR>" "Pane down")
          (luaMap "n" "<C-g>" ''
            function()
              vim.ui.input({ prompt = "Go to line: " }, function(input)
                local line = tonumber(input)
                if line then vim.api.nvim_win_set_cursor(0, { math.max(1, math.min(line, vim.api.nvim_buf_line_count(0))), 0 }) end
              end)
            end
          '' "Go to line")

          # Editing
          (remap "n" "<C-/>" "gcc" "Toggle comment")
          (remap "n" "<C-_>" "gcc" "Toggle comment")
          (remap "v" "<C-/>" "gc" "Toggle comment")
          (remap "v" "<C-_>" "gc" "Toggle comment")
          (kbmap "n" "<A-Up>" "<cmd>move .-2<CR>==" "Move line up")
          (kbmap "n" "<A-Down>" "<cmd>move .+1<CR>==" "Move line down")
          (kbmap "i" "<A-Up>" "<Esc><cmd>move .-2<CR>==gi" "Move line up")
          (kbmap "i" "<A-Down>" "<Esc><cmd>move .+1<CR>==gi" "Move line down")
          (kbmap "v" "<A-Up>" ":move '<-2<CR>gv=gv" "Move selection up")
          (kbmap "v" "<A-Down>" ":move '>+1<CR>gv=gv" "Move selection down")
          (kbmap "n" "<C-A-S-Up>" "<cmd>t.<CR>k" "Duplicate line up")
          (kbmap "n" "<C-A-S-Down>" "<cmd>t.<CR>" "Duplicate line down")

          # LSP (Zed's F-key bindings)
          (luaMap ["n" "v"] "<C-.>" "vim.lsp.buf.code_action" "Code actions")
          (luaMap "n" "<F2>" "vim.lsp.buf.rename" "Rename symbol")
          (luaMap "n" "<F12>" "vim.lsp.buf.definition" "Go to definition")
          (kbmap "n" "<A-F12>" "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>" "Go to definition (split)")
          (luaMap "n" "<C-F12>" "vim.lsp.buf.type_definition" "Go to type definition")
          (kbmap "n" "<S-F12>" (telescope "lsp_implementations") "Go to implementation")
          (kbmap "n" "<A-S-F12>" (telescope "lsp_references") "Find all references")
          (luaMap "n" "<C-k><C-i>" "vim.lsp.buf.hover" "Hover")
          (luaMap "n" "<F8>" "function() vim.diagnostic.jump({ count = 1, float = true }) end" "Next diagnostic")
          (luaMap "n" "<S-F8>" "function() vim.diagnostic.jump({ count = -1, float = true }) end" "Previous diagnostic")

          # Inline AI (Supermaven): Ctrl+Right takes one word of the suggestion
          # (Zed: AcceptPartialEditPrediction), otherwise moves a word as usual.
          (luaMap "i" "<C-Right>" ''
            function()
              local ok, preview = pcall(require, "supermaven-nvim.completion_preview")
              if ok and preview.has_suggestion() then
                preview.on_accept_suggestion_word()
              else
                vim.api.nvim_feedkeys(vim.keycode("<C-Right>"), "n", false)
              end
            end
          '' "Accept word of AI suggestion")
          (luaMap "i" "<C-]>" ''
            function()
              local ok, preview = pcall(require, "supermaven-nvim.completion_preview")
              if ok then preview.on_dispose_inlay() end
            end
          '' "Dismiss AI suggestion")
        ];

        lsp = {
          enable = true;
          formatOnSave = true;
          trouble.enable = true;
          lspSignature.enable = true;
          lightbulb.enable = true;
        };

        treesitter = {
          enable = true;
          context.enable = true;
          fold = true;
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
          enableDAP = true;

          bash.enable = true;
          clang.enable = false;
          css.enable = true;
          fish.enable = true;
          html.enable = true;
          json.enable = true;
          lua.enable = true;
          markdown.enable = true;
          nix.enable = true;
          python = {
            enable = true;
            lsp = {
              enable = true;
              servers = [
                # "pyrefly"
                "ruff"
                "ty"
              ];
            };
          };
          rust.enable = true;
          toml.enable = true;
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
            setupOpts.options.theme = "catppuccin";
            integrations.breadcrumbs = {
              # Zed: "toolbar": { "breadcrumbs": true } — shown above the buffer.
              location = "winbar";
              navbuddy.enable = true;
              nvim-navic.enable = true;
            };
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

          # Zed-style completion keys: arrows move through the menu, Tab/Enter
          # accept. When no menu is open, Tab accepts the AI suggestion.
          mappings = {
            next = null;
            previous = null;
          };
          setupOpts.mapping = {
            "<Tab>" = mkLuaInline ''
              cmp.mapping(function(fallback)
                local ok, preview = pcall(require, "supermaven-nvim.completion_preview")
                if cmp.visible() then
                  cmp.confirm({ select = true })
                elseif ok and preview.has_suggestion() then
                  preview.on_accept_suggestion()
                elseif luasnip.locally_jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = mkLuaInline ''
              cmp.mapping(function(fallback)
                if luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<Down>" = mkLuaInline ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_next_item() else fallback() end
              end, { "i", "s" })
            '';
            "<Up>" = mkLuaInline ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_prev_item() else fallback() end
              end, { "i", "s" })
            '';
            "<C-n>" = mkLuaInline ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_next_item() else fallback() end
              end, { "i", "s" })
            '';
            "<C-p>" = mkLuaInline ''
              cmp.mapping(function(fallback)
                if cmp.visible() then cmp.select_prev_item() else fallback() end
              end, { "i", "s" })
            '';
          };
        };
        snippets.luasnip.enable = true;

        # Zed: project panel on the left.
        filetree = {
          neo-tree = {
            enable = true;
            setupOpts = {
              close_if_last_window = true;
              window = {
                position = "left";
                width = 30;
              };
              filesystem = {
                # Directories are opened by the VimEnter hook above instead.
                hijack_netrw_behavior = "disabled";
                follow_current_file.enabled = true;
                use_libuv_file_watcher = true;
                filtered_items = {
                  # Zed shows dotfiles and git-ignored files (dimmed).
                  visible = true;
                  hide_dotfiles = false;
                  hide_gitignored = false;
                  never_show = [".git"];
                };
              };
            };
          };
        };

        # Zed: tab bar with git status and error markers.
        tabline = {
          nvimBufferline = {
            enable = true;
            setupOpts.options = {
              separator_style = "thin";
              always_show_bufferline = true;
              show_close_icon = false;
              offsets = [
                {
                  filetype = "neo-tree";
                  text = "Project";
                  highlight = "Directory";
                  separator = true;
                }
              ];
            };
          };
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope = {
          enable = true;
          # Zed's file finder shows dotfiles too (gitignored files stay hidden).
          setupOpts.pickers.find_files.find_command = [
            (lib.getExe pkgs.fd)
            "--type=file"
            "--hidden"
            "--exclude=.git"
          ];
          # Zed's project search respects .gitignore; nvf's default passes --no-ignore.
          setupOpts.defaults.vimgrep_arguments = [
            (lib.getExe pkgs.ripgrep)
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--hidden"
            "--glob=!.git/"
          ];
          extensions = [
            {
              name = "";
              packages = [
                pkgs.vimPlugins.telescope-fzf-native-nvim
              ];
              setup = {
                fzf = {
                  fuzzy = true;
                };
              };
            }
          ];
        };

        git = {
          enable = true;
          gitsigns = {
            enable = true;
            codeActions.enable = false;
            # Zed: "git": { "inline_blame": { "enabled": true } }
            setupOpts = {
              current_line_blame = true;
              current_line_blame_opts = {
                delay = 600;
                virt_text_pos = "eol";
              };
              current_line_blame_formatter = "<author>, <author_time:%R> • <summary>";
            };
          };
        };

        # Zed: "restore_on_startup": "last_session" — one session per project folder.
        session.nvim-session-manager = {
          enable = true;
          setupOpts = {
            autoload_mode = "CurrentDir";
            autosave_last_session = true;
            autosave_ignore_not_normal = true;
          };
        };

        utility = {
          diffview-nvim.enable = true;
          icon-picker.enable = true;
          motion.leap.enable = true;
          multicursors.enable = true;
          direnv.enable = true;
          sleuth.enable = true;
          # Zed: project-wide search & replace (ctrl-shift-h).
          grug-far-nvim.enable = true;
          # Zed: outline panel (ctrl-shift-b), docked on the right.
          outline.aerial-nvim = {
            enable = true;
            setupOpts.layout.default_direction = "right";
          };
        };

        # Zed: terminal in the bottom dock (ctrl-` / ctrl-j).
        terminal = {
          toggleterm = {
            enable = true;
            mappings.open = "<C-`>";
            setupOpts = {
              direction = "horizontal";
              size = 15;
            };
            lazygit.enable = true;
          };
        };

        ui = {
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          # breadcrumbs = {
          #   enable = true;
          #   navbuddy.enable = true;
          # };
          fastaction.enable = true;
        };

        # Zed: inline edit predictions. Tab / Ctrl+Right / Ctrl+] are wired up in
        # the completion mappings and keymaps above.
        assistant = {
          supermaven-nvim = {
            enable = false;
            setupOpts.disable_keymaps = true;
          };
        };

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
