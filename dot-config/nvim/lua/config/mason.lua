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
		"jsonls",
		"basedpyright",
		"ruff",
		-- "tailwindcss",
	},
})
require("mason-null-ls").setup({
	ensure_installed = { "stylua", "jq", "black", "prettierd", "prettier" },
})

local lsp_config = require("lspconfig")
local capabilities = require("config.lsp").capabilities
local handlers = require("config.lsp").handlers

local function on_attach(client, bufnr, noformat)
	if noformat then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
	require("config.lsp").on_attach(client, bufnr)
end

local function setup_server(server_name, config)
	config = config or {}
	config.capabilities = config.capabilities or capabilities
	config.handlers = config.handlers or handlers
	config.on_attach = function(client, bufnr)
		on_attach(client, bufnr, config.noformat)
		if config.custom_attach then
			config.custom_attach(client, bufnr)
		end
	end
	lsp_config[server_name].setup(config)
end

require("mason-lspconfig").setup_handlers({
	function(server_name)
		if server_name == "rust_analyzer" then
			return
		end

		setup_server(server_name, { noformat = true })
	end,

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

		setup_server("ts_ls", {
			filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
			custom_attach = function(client, bufnr)
				require("twoslash-queries").attach(client, bufnr)
			end,
			settings = {
				typescript = { inlayHints = inlayHints },
				javascript = { inlayHints = inlayHints },
			},
			noformat = true,
		})
	end,

	["svelte"] = function()
		setup_server("svelte", {
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
		setup_server("astro")
	end,

	["lua_ls"] = function()
		setup_server("lua_ls", {
			noformat = true,
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
		setup_server("gopls", {
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
		setup_server("unocss", {
			noformat = true,
			filetypes = { "typescriptreact", "astro", "svelte" },
		})
	end,
	["basedpyright"] = function()
		setup_server("basedpyright", {
			noformat = true,
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
		setup_server("volar", {
			filetypes = { "vue" },
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})
	end,

	["emmet_language_server"] = function()
		setup_server("emmet_language_server", {
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
			init_options = {
				---@type table<string, string>
				includeLanguages = { typescriptreact = "html" },
				--- @type string[]
				excludeLanguages = {},
				--- @type string[]
				extensionsPath = {},
				---@type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
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
		setup_server("jsonls", {
			noformat = true,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
	end,
	["yamlls"] = function()
		setup_server("yamlls", {
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
		setup_server("ruff", {
			noformat = true,
			custom_attach = function(client)
				client.server_capabilities.hoverProvider = false
			end,
		})
	end,
})
