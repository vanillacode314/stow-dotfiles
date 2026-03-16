local defaults = require("lsp-utils")

return {
	capabilities = defaults.capabilities,
	on_attach = defaults.on_attach,
	settings = {
		hints = {
			rangeVariableTypes = true,
			parameterNames = true,
			constantValues = true,
			assignVariableTypes = true,
			compositeLiteralFields = true,
			compositeLiteralTypes = true,
			functionTypeParameters = true,
		},
	},
}
