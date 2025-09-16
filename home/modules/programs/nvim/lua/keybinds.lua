-- Keybinds that are NOT handled by whichkey

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Control+Tab to switch buffer tabs
keymap("n", "<C-Tab>", "<cmd>BufferLineCycleNext<cr>", opts)
keymap("n", "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Insert --
keymap("i", "<C-BS>", "<C-W>", opts)

-- Switch between tabs with Alt+number
keymap("n", "<M-1>", ":BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<M-2>", ":BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<M-3>", ":BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<M-4>", ":BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<M-5>", ":BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<M-6>", ":BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<M-7>", ":BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<M-8>", ":BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<M-9>", ":BufferLineGoToBuffer 9<CR>", opts)
keymap("n", "<M-0>", ":tablast<CR>", opts)
