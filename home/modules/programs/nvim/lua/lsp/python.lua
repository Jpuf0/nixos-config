vim.lsp.config("ty", {
  settings = {
    ty = {

    }
  }
})

vim.lsp.config("ruff", {
  init_options = {
    settings = {}
  }
})

vim.lsp.enable('ty')
vim.lsp.enable('ruff')
