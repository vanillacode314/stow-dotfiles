return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		enabled = false,
		opts = {},
		keys = {
			{ "<leader>tc", "<cmd>TSContextToggle<cr>", desc = "Toggle Context" },
		},
	},
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {
			opts = {
				enable = true,
				enable_rename = false,
				enable_close = true,
				enable_close_on_slash = true,
				filetypes = {
					"astro",
					"html",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"svelte",
					"vue",
					"tsx",
					"jsx",
					"rescript",
					"xml",
					"php",
					"markdown",
					"glimmer",
					"handlebars",
					"hbs",
				},
			},
		},
	},
	{
		"romus204/tree-sitter-manager.nvim",
		config = function()
			require("tree-sitter-manager").setup({
				highlight = true,
				auto_install = true,
			})
		end,
	},
}
