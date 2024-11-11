return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		enabled = true,
		opts = {},
		keys = {
			{ "<leader>tc", "<cmd>TSContextToggle<cr>", desc = "Toggle Context" },
		},
	},
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
	},
	{
		"windwp/nvim-autopairs",
		opts = {},
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter",
		},
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
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-textsubjects",
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyInstall",
				callback = function()
					vim.cmd(":TSUpdate")
				end,
			})
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"typescript",
					"javascript",
					"python",
					"bash",
					"fish",
					"sql",
					"lua",
					"astro",
					"css",
					"html",
				},
				ignore_install = {},
				modules = {},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				indent = {
					enable = true,
					-- disable = { "python" },
				},
				-- rainbow = {
				-- 	enable = true,
				-- 	-- list of languages you want to disable the plugin for
				-- 	-- Which query to use for finding delimiters
				-- 	query = "rainbow-parens",
				-- 	-- Highlight the entire buffer all at once
				-- 	strategy = require("ts-rainbow").strategy.global,
				-- },
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
						-- You can choose the select mode (default is charwise 'v')
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					lsp_interop = {
						enable = true,
						border = "rounded",
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
				textsubjects = {
					enable = true,
					prev_selection = ",", -- (Optional) keymap to select the previous selection
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
					},
				},
			})
		end,
	},
}
