return {
	{
		"mason-org/mason.nvim",
		-- cmd = {
		-- 	"Mason",
		-- 	"MasonInstall",
		-- 	"MasonUninstall",
		-- 	"MasonUninstallAll",
		-- 	"MasonLog",
		-- 	"MasonUpdate",
		-- 	"MasonUpdateAll",
		-- },
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
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
			automatic_enable = {
				exclude = {
					"ts_ls",
				},
			},
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = { "stylua", "jq", "black", "prettierd", "prettier" },
		},
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	{
		"Zeioth/mason-extra-cmds",
		opts = {},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyInstall",
				callback = function()
					vim.cmd(":MasonUpdateAll")
				end,
			})
		end,
	},
}
