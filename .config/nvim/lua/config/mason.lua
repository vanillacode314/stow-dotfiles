require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"wgsl_analyzer",
		"tsserver",
		"svelte",
		"astro",
		"pyright",
		"volar",
		-- "tailwindcss",
	},
})

local function on_attach(noformat)
	return function(client, bufnr)
		if noformat then
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
		require("config.lsp").on_attach(client, bufnr)
	end
end

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach(true),
			capabilities = require("config.lsp").capabilities,
			handlers = require("config.lsp").handlers,
		})
	end,

	["rust_analyzer"] = function()
		require("rust-tools").setup({
			tools = {
				inlay_hints = {
					auto = false,
				},
			},
			server = {
				on_attach = on_attach(false),
				capabilities = require("config.lsp").capabilities,
				handlers = require("config.lsp").handlers,
			},
		})
	end,
	["tsserver"] = function()
		require("typescript").setup({
			server = {
				filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
				on_attach = on_attach(true),
				capabilities = require("config.lsp").capabilities,
				handlers = require("config.lsp").handlers,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			},
		})
	end,

	["svelte"] = function()
		require("lspconfig").svelte.setup({
			on_attach = on_attach(false),
			capabilities = require("config.lsp").capabilities,
			handlers = require("config.lsp").handlers,
		})
	end,

	["astro"] = function()
		require("lspconfig").astro.setup({
			on_attach = on_attach(false),
			capabilities = require("config.lsp").capabilities,
			handlers = require("config.lsp").handlers,
		})
	end,

	["lua_ls"] = function()
		require("lspconfig").lua_ls.setup({
			on_attach = on_attach(true),
			capabilities = require("config.lsp").capabilities,
			handlers = require("config.lsp").handlers,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,

	["unocss"] = function()
		require("lspconfig").unocss.setup({
			on_attach = on_attach(true),
			capabilities = require("config.lsp").capabilities,
			handlers = require("config.lsp").handlers,
			filetypes = { "typescriptreact", "astro" },
		})
	end,
})
