vim.lsp.config("bashls", {
	single_file_support = true,
	cmd = { "bash-language-server", "start" },
})
vim.lsp.enable("bashls")
