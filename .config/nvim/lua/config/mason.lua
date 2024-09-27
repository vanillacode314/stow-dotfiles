require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"wgsl_analyzer",
		"svelte",
		"astro",
		"volar",
		"ts_ls",
		"gopls",
		"emmet_language_server",
		"jsonls",
		"basedpyright",
		"ruff",
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
	["ts_ls"] = function()
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
		require("lspconfig").ts_ls.setup({
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
			on_attach = on_attach(true),
			capabilities = require("config.lsp").capabilities,
			handlers = require("config.lsp").handlers,
			settings = {
				basedpyright = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
						-- ignore = { "*" },
					},
					disableOrganizeImports = true,
				},
			},
		})
	end,
	["volar"] = function()
		local util = require("lspconfig.util")
		local function get_typescript_server_path(root_dir)
			-- local global_ts = "/home/vc/.npm/lib/node_modules/typescript/lib"
			-- Alternative location if installed as root:
			local global_ts = "/usr/lib/node_modules/typescript/lib"
			local found_ts = ""
			local function check_dir(path)
				found_ts = util.path.join(path, "node_modules", "typescript", "lib")
				if util.path.exists(found_ts) then
					return path
				end
			end
			if util.search_ancestors(root_dir, check_dir) then
				return found_ts
			else
				return global_ts
			end
		end

		require("lspconfig").volar.setup({
			on_new_config = function(new_config, new_root_dir)
				new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
			end,
			-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			filetypes = { "vue" },
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})
	end,

	["emmet_language_server"] = function()
		require("lspconfig").emmet_language_server.setup({
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
			},
			-- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
			-- **Note:** only the options listed in the table are supported.
			init_options = {
				---@type table<string, string>
				includeLanguages = { typescriptreact = "html" },
				--- @type string[]
				excludeLanguages = {},
				--- @type string[]
				extensionsPath = {},
				--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
				preferences = {},
				--- @type boolean Defaults to `true`
				showAbbreviationSuggestions = true,
				--- @type "always" | "never" Defaults to `"always"`
				showExpandedAbbreviation = "always",
				--- @type boolean Defaults to `false`
				showSuggestionsAsSnippets = false,
				--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
				syntaxProfiles = {},
				--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
				variables = {},
			},
		})
	end,
	["jsonls"] = function()
		require("lspconfig").jsonls.setup({
			on_attach = on_attach(true),
			capabilities = require("config.lsp").capabilities,
			handlers = require("config.lsp").handlers,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
	end,
	["yamlls"] = function()
		require("lspconfig").yamlls.setup({
			settings = {
				yaml = {
					schemaStore = {
						-- You must disable built-in schemaStore support if you want to use
						-- this plugin and its advanced options like `ignore`.
						enable = false,
						-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})
	end,
	["ruff"] = function()
		require("lspconfig").ruff.setup({
			on_attach = function(client, bufnr)
				on_attach(true)(client, bufnr)
				client.server_capabilities.hoverProvider = false
			end,
		})
	end,
})
