require("config.diagnostics")

local M = {}

-- M.capabilities = require("cmp_nvim_lsp").default_capabilities()
M.capabilities = require("blink.cmp").get_lsp_capabilities()
-- M.capabilites = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M.on_attach = function(client, bufnr)
	if not bufnr then
		bufnr = 0
	end

	if client.name == "eslint" then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end
	vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, {
			bufnr = bufnr,
		})
	end

	-- Keymaps
	local client_opts = { remap = false, silent = true, buffer = bufnr }
	-- vim.keymap.set(
	-- 	"n",
	-- 	"<space>q",
	-- 	vim.diagnostic.setloclist,
	-- 	vim.tbl_extend("force", client_opts, { desc = "Add Diagnostic to loclist" })
	-- )
	vim.keymap.set(
		"n",
		"gi",
		vim.lsp.buf.implementation,
		vim.tbl_extend("force", client_opts, { desc = "List Implementations" })
	)
	vim.keymap.set(
		"n",
		"<C-K>",
		vim.lsp.buf.signature_help,
		vim.tbl_extend("force", client_opts, { desc = "Signature Help" })
	)
	vim.keymap.set(
		"n",
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		vim.tbl_extend("force", client_opts, { desc = "Add Workspace Folder" })
	)
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		vim.tbl_extend("force", client_opts, { desc = "Remove Workspace Folder" })
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, vim.tbl_extend("force", client_opts, { desc = "Print Workspace Folders" }))
	vim.keymap.set(
		"n",
		"<leader>D",
		vim.lsp.buf.type_definition,
		vim.tbl_extend("force", client_opts, { desc = "Jump To Type Definition" })
	)
	vim.keymap.set("n", "<leader>ca", function()
		require("fastaction").code_action()
	end, vim.tbl_extend("force", client_opts, { desc = "Code Actions" }))
	vim.keymap.set(
		"n",
		"<leader>rn",
		vim.lsp.buf.rename,
		vim.tbl_extend("force", client_opts, { desc = "Rename Symbol" })
	)
	vim.keymap.set("n", "<leader>fj", function()
		-- vim.lsp.buf.format({ async = true })
		require("conform").format({ async = true })
		vim.cmd("w")
	end, vim.tbl_extend("force", client_opts, { desc = "Format Buffer" }))

	-- Setup plugins
	require("better-diagnostic-virtual-text.api").setup_buf(bufnr, {})
end

local disabled_servers = { rust_analyzer = true }

local function on_attach(client, bufnr, noformat)
	if noformat then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end
	M.on_attach(client, bufnr)
end

local function setup_server(server_name, config)
	if disabled_servers[server_name] then
		return
	end
	config = config or {}
	config.capabilities = config.capabilities or M.capabilities
	config.on_attach = function(client, bufnr)
		on_attach(client, bufnr, config.noformat)
		if config.custom_attach then
			config.custom_attach(client, bufnr)
		end
	end
	vim.lsp.config(server_name, config)
end

-- setup_server("*", { noformat = true })

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
	settings = {
		typescript = { inlayHints = inlayHints },
		javascript = { inlayHints = inlayHints },
	},
	noformat = true,
})

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
setup_server("unocss", {
	noformat = true,
	filetypes = { "typescriptreact", "astro", "svelte" },
})
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
setup_server("vue_ls", {
	filetypes = { "vue" },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
})
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
setup_server("jsonls", {
	noformat = true,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
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
setup_server("ruff", {
	noformat = true,
	custom_attach = function(client)
		client.server_capabilities.hoverProvider = false
	end,
})

return M
