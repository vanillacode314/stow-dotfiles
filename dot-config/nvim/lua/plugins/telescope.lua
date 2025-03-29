return {
	enabled = false,
	"nvim-telescope/telescope.nvim",
	dependencies = {
		-- "nvim-telescope/telescope-ui-select.nvim",
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		"nvim-telescope/telescope-symbols.nvim",
	},
	cmd = { "Telescope" },
	init = function()
		local opts = { noremap = true }
		vim.keymap.set("n", "<leader>ff", function()
			require("telescope.builtin").find_files()
		end, opts)
		vim.keymap.set("n", "<leader>fg", function()
			require("telescope.builtin").live_grep()
		end, opts)
		vim.keymap.set("n", "<leader>fb", function()
			require("telescope.builtin").buffers()
		end, opts)
		vim.keymap.set("n", "<leader>fh", function()
			require("telescope.builtin").help_tags()
		end, opts)
		vim.keymap.set("n", "<leader>fs", function()
			require("telescope.builtin").lsp_document_symbols()
		end, opts)
		vim.keymap.set("n", "<leader>fw", function()
			require("telescope.builtin").lsp_workspace_symbols()
		end, opts)
	end,
	config = function()
		require("telescope").setup({
			defaults = {
				borderchars = {
					prompt = require("utils").border_chars_outer_thin_telescope,
					results = require("utils").border_chars_outer_thin_telescope,
					preview = require("utils").border_chars_outer_thin_telescope,
				},
				border = {
					prompt = true,
					results = true,
					preview = true,
				},
				sort_mru = true,
				multi_icon = "",
				hl_result_eol = true,
				results_title = "",
				winblend = 0,
				wrap_results = true,
				entry_prefix = "   ",
				prompt_prefix = "   ",
				selection_caret = "  ",
			},
			pickers = {
				find_files = {
					theme = "dropdown",
				},
				live_grep = {
					theme = "dropdown",
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_cursor(),
				},
				undo = {
					use_delta = true,
					use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
					side_by_side = false,
					vim_diff_opts = { ctxlen = 999 },
					entry_format = "state #$ID, $STAT, $TIME",
					mappings = {
						i = {
							-- IMPORTANT Note that telescope-undo must be available when telescope is configured if
							-- you want to replicate these defaults and use the following actions. This means
							-- installing as a dependency of telescope in it's `requirements` and loading this
							-- extension from there instead of having the separate plugin definition as outlined
							-- above.
							["<cr>"] = require("telescope-undo.actions").yank_additions,
							["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
							["<C-cr>"] = require("telescope-undo.actions").restore,
						},
					},
				},
			},
		})
		require("telescope").load_extension("undo")
		-- require("telescope").load_extension("ui-select")
	end,
}
