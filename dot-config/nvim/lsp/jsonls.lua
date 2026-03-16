local defaults = require("lsp-utils")

return {
	capabilities = defaults.capabilities,
	on_attach = defaults.on_attach,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
}
