vim.lsp.config("vtsls", {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        variableTypes = { enabled = true },
        returnTypes = { enabled = true },
      }
    }
  },
})

vim.lsp.enable("vtsls")

require("vtsls").config({
  refactor_auto_rename = true,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    local vtsls = require("vtsls")
    vtsls.commands.fix_all(0)
    vtsls.commands.organize_imports(0)
  end,
})
