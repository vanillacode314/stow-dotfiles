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
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"emmylua_ls",
				"fish_lsp",
				"nil_ls",
				"rust_analyzer",
				"wgsl_analyzer",
				"svelte",
				"astro",
				"vue_ls",
				"ts_ls",
				"gopls",
				"jsonls",
				"basedpyright",
				"ruff",
				"tailwindcss",
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
