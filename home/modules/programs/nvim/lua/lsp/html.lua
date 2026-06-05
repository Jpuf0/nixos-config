local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("html", {
	capabilities = capabilities,
	cmd = { "vscode-html-language-server", "--stdio" },
})
vim.lsp.enable("html")
