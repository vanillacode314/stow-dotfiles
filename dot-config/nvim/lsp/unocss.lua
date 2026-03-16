local defaults = require("lsp-utils")

return {
	capabilities = defaults.capabilities,
	on_attach = defaults.on_attach,
	filetypes = { "typescriptreact", "astro", "svelte" },
}

