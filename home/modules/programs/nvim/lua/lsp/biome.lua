vim.lsp.config("biome", {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "biome.json", "biome.jsonc" },
})

vim.lsp.enable("biome")
