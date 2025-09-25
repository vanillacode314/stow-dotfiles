local defaults = require("lsp-utils")

return {
	capabilities = defaults.capabilities,
	on_attach = defaults.on_attach,
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	settings = {
		typescript = { inlayHints = defaults.inlayHints },
		javascript = { inlayHints = defaults.inlayHints },
	},
}
