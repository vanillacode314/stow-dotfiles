require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"wgsl_analyzer",
		"svelte",
		"astro",
		"pylyzer",
		"volar",
		"tsserver",
		"gopls",
		-- "tailwindcss",
	},
})
require("mason-null-ls").setup({
	ensure_installed = { "stylua", "jq", "black", "prettierd", "prettier" },
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

	["rust_analyzer"] = function() end,
	["tsserver"] = function()
		local inlayHints = {
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		}
		require("typescript").setup({
			server = {
				filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
				on_attach = on_attach(true),
				capabilities = require("config.lsp").capabilities,
				handlers = require("config.lsp").handlers,
				settings = {
					typescript = {
						inlayHints = inlayHints,
					},
					javascript = {
						inlayHints = inlayHints,
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
			settings = {
				typescript = {
					inlayHints = {
						parameterNames = { enabled = "all" },
						parameterTypes = { enabled = true },
						variableTypes = { enabled = true },
						propertyDeclarationTypes = { enabled = true },
						functionLikeReturnTypes = { enabled = true },
						enumMemberValues = { enabled = true },
					},
				},
			},
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
					hint = { enable = true },
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,

	["gopls"] = function()
		require("lspconfig").gopls.setup({
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
		})
	end,

	["unocss"] = function()
		require("lspconfig").unocss.setup({
			on_attach = on_attach(true),
			capabilities = require("config.lsp").capabilities,
			handlers = require("config.lsp").handlers,
			filetypes = { "typescriptreact", "astro", "svelte" },
		})
	end,
	["basedpyright"] = function()
		require("lspconfig").basedpyright.setup({
			settings = {
				basedpyright = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
					},
				},
			},
		})
	end,
})
