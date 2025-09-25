local defaults = require("lsp-utils")

return {
	capabilities = defaults.capabilities,
	on_attach = defaults.on_attach,
	settings = {
		Lua = {
			hint = { enable = true },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}
