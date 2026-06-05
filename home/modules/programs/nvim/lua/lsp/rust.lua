vim.lsp.config("rust_analyzer", {
	single_file_support = true,
	root_markers = { "Cargo.toml", "rust-project.json" },
})
vim.lsp.enable("rust_analyzer")
