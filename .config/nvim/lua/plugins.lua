vim.g.mapleader = " "
-- convert config to use lazy.nvim instead of packer.nvim
require("lazy").setup({
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"wbthomason/packer.nvim",
	"lervag/vimtex",
	{
		"lewis6991/gitsigns.nvim",
		-- version = 'release' -- To use the latest release
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({ -- Optional, you don't have to run setup.
				groups = { -- table: default groups
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					"CursorLine",
					"CursorLineNr",
					"StatusLine",
					"StatusLineNC",
					"EndOfBuffer",
					"WinBar",
					"WinSeparator",
					"lualine_b_normal",
					"lualine_b_inactive",
					"lualine_c_normal",
					"lualine_c_inactive",
					"lualine_y_normal",
					"lualine_y_inactive",
				},
				extra_groups = {}, -- table: additional groups that should be cleared
				exclude_groups = {}, -- table: groups you don't want to clear
			})
			-- require("transparent").clear_prefix("BufferLine")
			-- require("transparent").clear_prefix("lualine")
		end,
	},
	"RRethy/nvim-base16",
	{
		"Mofiqul/vscode.nvim",
		config = function()
			require("vscode").setup({})
		end,
	},
	{
		"Exafunction/codeium.vim",
		enabled = not vim.g.__streaming,
		config = function()
			-- require("codeium").setup({})
			vim.keymap.set("i", "<C-j>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
	},

	"folke/lsp-colors.nvim",
	{
		"folke/zen-mode.nvim",
		cmd = { "ZenMode" },
		config = function()
			local quitting = false
			vim.api.nvim_create_autocmd("QuitPre", {
				group = vim.api.nvim_create_augroup("ZenMode", { clear = true }),
				callback = function()
					quitting = true
				end,
			})
			require("zen-mode").setup({
				plugins = {
					options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
						-- you may turn on/off statusline in zen mode by setting 'laststatus'
						-- statusline will be shown only if 'laststatus' == 3
						laststatus = 0, -- turn off the statusline in zen mode
					},
					-- alacritty = {
					-- 	enabled = true,
					-- 	font = "14",
					-- },
					kitty = {
						enabled = true,
						font = "+4",
					},
					tmux = {
						enabled = true,
					},
				},
				on_open = function()
					-- io.popen("bspc node -t fullscreen")
					-- vim.cmd([[ScrollbarHide]])
				end,
				on_close = function()
					-- io.popen("bspc node -t tiled")
					-- vim.cmd([[ScrollbarShow]])
					if quitting then
						quitting = false
						vim.cmd("q")
					end
				end,
			})
		end,
	},
	{
		"folke/twilight.nvim",
		cmd = { "Twilight" },
		config = function()
			vim.keymap.set({ "n" }, "<leader>t", function()
				vim.cmd("Twilight")
			end)
			require("twilight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},

	{
		"booperlv/nvim-gomove",
		config = true,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		enabled = false,
		config = true,
	},

	"onsails/lspkind-nvim",

	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	-- TREESITTER
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	},
	{
		"virchau13/tree-sitter-astro",
		ft = { "astro" },
	},
	{
		"nvim-treesitter/playground",
		requires = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"windwp/nvim-autopairs",
		config = true,
	},

	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup({
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
			})
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.lualine")
		end,
	},

	-- {
	-- 	"freddiehaddad/feline.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("config.feline")
	-- 	end,
	-- },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"kylechui/nvim-surround",
		-- version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("config.snippets")
			require("luasnip.loaders.from_snipmate").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		dependencies = {
			"fivethree-team/vscode-svelte-snippets",
			{ "solidjs-community/solid-snippets", filetypes = { "html", "typescriptreact" } },
			"rafamadriz/friendly-snippets",
			{ "sdras/vue-vscode-snippets", filetypes = { "vue" } },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"lukas-reineke/cmp-rg",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"jcha0713/cmp-tw2css",
		},
		config = function()
			require("config.cmp")
		end,
	},

	{ "tzachar/cmp-tabnine", enabled = false, build = "./install.sh", dependencies = "hrsh7th/nvim-cmp" },
	"lukas-reineke/cmp-under-comparator",

	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	-- {
	-- 	"lucastavaresa/SingleComment.nvim",
	-- 	config = function()
	-- 		-- comments the current line, or a number of lines 5gcc
	-- 		vim.keymap.set("n", "gcc", require("SingleComment").SingleComment, { expr = true })
	-- 		-- comments the selected lines
	-- 		vim.keymap.set("v", "gcc", require("SingleComment").Comment, {})
	-- 		-- toggle a comment top/ahead of the current line
	-- 		vim.keymap.set("n", "gca", require("SingleComment").ToggleCommentAhead, {})
	-- 		-- comments ahead of the current line
	-- 		vim.keymap.set("n", "gcA", require("SingleComment").CommentAhead, {})
	-- 		-- comment a block, and removes the innermost block comment in normal mode
	-- 		vim.keymap.set({ "n", "v" }, "gcb", require("SingleComment").BlockComment)
	-- 	end,
	-- },
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = true,
		setup = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
	},

	"wellle/targets.vim",

	{
		"nvimdev/lspsaga.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		branch = "main",
		config = function()
			local lspsaga = require("lspsaga")
			lspsaga.setup({
				ui = {
					border = require("utils").border_chars_outer_thin,
				},
				outline = {
					win_position = "right",
					win_with = "",
					win_width = 30,
					preview_width = 0.4,
					show_detail = true,
					auto_preview = true,
					auto_refresh = true,
					auto_close = true,
					custom_sort = nil,
					keys = {
						expand_or_collapse = "o",
						quit = "q",
					},
				},
				lightbulb = {
					enable = false,
					enable_in_insert = true,
					sign = false,
					sign_priority = 40,
					virtual_text = false,
				},
			})
			vim.keymap.set({ "n", "t" }, "<A-i>", "<cmd>Lspsaga term_toggle<cr>", { silent = true, noremap = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("lspsaga_filetypes", { clear = true }),
				pattern = "LspsagaHover",
				command = "nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>",
			})
		end,
	},
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "v3.*",
	-- 	dependencies = "nvim-tree/nvim-web-devicons",
	-- 	opts = {
	-- 		options = {},
	-- 	},
	-- },
	{
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended
		config = function()
			require("hop").setup({})
			-- place this in one of your configuration file(s)
			vim.api.nvim_set_keymap(
				"n",
				"f",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
				{}
			)
			vim.api.nvim_set_keymap(
				"n",
				"F",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
				{}
			)
			vim.api.nvim_set_keymap(
				"o",
				"f",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
				{}
			)
			vim.api.nvim_set_keymap(
				"o",
				"F",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>",
				{}
			)
			vim.api.nvim_set_keymap(
				"",
				"t",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
				{}
			)
			vim.api.nvim_set_keymap(
				"",
				"T",
				"<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
				{}
			)
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		init = function()
			vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.opt.foldcolumn = "0"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = -1
			vim.opt.foldenable = true
		end,
		config = function()
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2rd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end
			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
				fold_virt_text_handler = handler,
			})
		end,
	},
	{
		"ellisonleao/carbon-now.nvim",
		enabled = false,
		config = function()
			require("carbon-now").setup()
			vim.keymap.set("v", "<leader>cn", function()
				require("carbon-now").create_snippet()
			end, { noremap = true, silent = true })
		end,
	},
	{
		"derektata/lorem.nvim",
		enabled = false,
		config = true,
		dependencies = "vim-scripts/loremipsum",
	},
	"jose-elias-alvarez/typescript.nvim",
	{
		"Abstract-IDE/penvim",
		config = function()
			require("penvim").setup({
				rooter = {
					enable = true, -- enable/disable rooter
					--[[ patterns = { "pnpm-workspace.yaml", ".__nvim__.lua", ".git", "node_modules" }, ]]
				},
				indentor = {
					enable = true, -- enable/disable indentor
					indent_length = 2, -- tab indent width
					accuracy = 5, -- positive integer. higher the number, the more accurate result (but affects the startup time)
					disable_types = {
						"help",
						"dashboard",
						"dashpreview",
						"NvimTree",
						"vista",
						"sagahover",
						"terminal",
					},
				},
				project_env = {
					enable = true, -- enable/disable project_env
					--[[ config_name = ".__nvim__.lua", -- config file name ]]
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
			local opts = { silent = true, noremap = true }
			vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
			vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
			vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo<cr>", opts)
			vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
			vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
			vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
			vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
		end,
	},
	{
		"vimpostor/vim-tpipeline",
		enabled = false,
		config = function()
			vim.g.tpipeline_cursormoved = 1
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
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
		end,
		config = function()
			require("telescope").setup({
				defaults = {
					borderchars = {
						prompt = require("utils").border_chars_outer_thin_telescope,
						results = require("utils").border_chars_outer_thin_telescope,
						preview = require("utils").border_chars_outer_thin_telescope,
					},
					border = true,
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
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
						-- the following line works
						-- require("telescope.themes").get_dropdown({ initial_mode = "normal" }),
					},
					undo = {
						use_delta = true,
						use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
						side_by_side = false,
						diff_context_lines = vim.o.scrolloff,
						entry_format = "state #$ID, $STAT, $TIME",
						mappings = {
							i = {
								-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
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
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"Shatur/neovim-session-manager",
		config = function()
			local Path = require("plenary.path")
			require("session_manager").setup({
				sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
				path_replacer = "__", -- The character to which the path separator will be replaced for session files.
				colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
				autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				autosave_last_session = true, -- Automatically save last session on exit and on session switch.
				autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
				autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
					"gitcommit",
				},
				autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
				max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
			})
		end,
	},
	{
		"numToStr/FTerm.nvim",
		enabled = false,
		config = function()
			vim.keymap.set("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>')
			vim.keymap.set("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
		end,
	},
	{
		"folke/which-key.nvim",
		enabled = false,
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				triggers = { "<Space>" },
			})
		end,
	},
	{
		"SmiteshP/nvim-navic",
		enabled = false,
		config = function()
			require("nvim-navic").setup({
				highlight = true,
			})
		end,
		dependencies = "neovim/nvim-lspconfig",
	},
	{
		"rktjmp/highlight-current-n.nvim",
		config = function()
			require("highlight_current_n").setup({
				highlight_group = "IncSearch", -- highlight group name to use for highlight
			})
			vim.cmd([[
						nmap n <Plug>(highlight-current-n-n)
						nmap N <Plug>(highlight-current-n-N)
						autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
						nmap * *N

						" Some QOL autocommands
						augroup ClearSearchHL
						autocmd!
						" You may only want to see hlsearch /while/ searching, you can automatically
						" toggle hlsearch with the following autocommands
						autocmd CmdlineEnter /,\? set hlsearch
						autocmd CmdlineLeave /,\? set nohlsearch
						" this will apply similar n|N highlighting to the first search result
						" careful with escaping ? in lua, you may need \\?
						autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
						augroup END
						]])
		end,
	},
	-- {
	-- 	"petertriho/nvim-scrollbar",
	-- 	config = function()
	-- 		require("scrollbar").setup()
	-- 		require("scrollbar.handlers.gitsigns").setup()
	-- 	end,
	-- },
	-- {
	-- 	"gorbit99/codewindow.nvim",
	-- 	config = function()
	-- 		local codewindow = require("codewindow")
	-- 		codewindow.setup()
	-- 		codewindow.apply_default_keybinds()
	-- 	end,
	-- },
	"RRethy/nvim-treesitter-textsubjects",
	{
		"nvim-treesitter/nvim-treesitter-context",
		enabled = false,
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				patterns = {
					-- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"class",
						"function",
						"call",
						"method",
						"for",
						"while",
						"if",
						"switch",
						"case",
					},
					-- Patterns for specific filetypes
					-- If a pattern is missing, *open a PR* so everyone can benefit.
					tex = {
						"chapter",
						"section",
						"subsection",
						"subsubsection",
					},
					rust = {
						"impl_item",
						"struct",
						"enum",
					},
					scala = {
						"object_definition",
					},
					vhdl = {
						"process_statement",
						"architecture_body",
						"entity_declaration",
					},
					markdown = {
						"section",
					},
					elixir = {
						"anonymous_function",
						"arguments",
						"block",
						"do_block",
						"list",
						"map",
						"tuple",
						"quoted_content",
					},
					json = {
						"pair",
					},
					yaml = {
						"block_mapping_pair",
					},
				},
				exact_patterns = {
					-- Example for a specific filetype with Lua patterns
					-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
					-- exactly match "impl_item" only)
					-- rust = true,
				},
				-- [!] The options below are exposed but shouldn't require your attention,
				--     you can safely ignore them.

				zindex = 20, -- The Z-index of the context window
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
			})
		end,
	},
	{
		"kkoomen/vim-doge",
		build = ":call doge#install()",
		enabled = false,
		init = function()
			vim.g.doge_filetype_aliases = {
				javascript = {
					"vue",
					"svelte",
				},
			}
		end,
	},
	{
		"MunifTanjim/exrc.nvim",
		config = function()
			-- disable built-in local config file support
			vim.o.exrc = false

			require("exrc").setup({
				files = {
					".nvimrc.lua",
					".nvimrc",
					".exrc.lua",
					".exrc",
				},
			})
		end,
	},
	-- DAP
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
				name = "lldb",
			}
			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
			}

			-- If you want to use this for Rust and C, add something like this:

			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"williamboman/mason.nvim",
		config = function()
			require("config.mason")
		end,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("config.nullls")
			require("mason-null-ls").setup()
		end,
	},
	{
		"aserowy/tmux.nvim",
		config = function()
			return require("tmux").setup({
				copy_sync = {
					enabled = false,
				},
			})
		end,
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup({
				autowidth = {
					enable = true,
					winwidth = 5,
					filetype = {
						help = 2,
					},
				},
				ignore = {
					buftype = { "quickfix" },
					filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "lspsagaoutline", "Outline" },
				},
				animation = {
					enable = true,
					duration = 300,
					fps = 30,
					easing = "in_out_sine",
				},
			})
		end,
	},
	{
		"sindrets/winshift.nvim",
		config = function()
			-- Lua
			require("winshift").setup({
				highlight_moving_win = true, -- Highlight the window being moved
				focused_hl_group = "Visual", -- The highlight group used for the moving window
				moving_win_options = {
					-- These are local options applied to the moving window while it's
					-- being moved. They are unset when you leave Win-Move mode.
					wrap = false,
					cursorline = false,
					cursorcolumn = false,
					colorcolumn = "",
				},
				keymaps = {
					disable_defaults = false, -- Disable the default keymaps
					win_move_mode = {
						["h"] = "left",
						["j"] = "down",
						["k"] = "up",
						["l"] = "right",
						["H"] = "far_left",
						["J"] = "far_down",
						["K"] = "far_up",
						["L"] = "far_right",
						["<left>"] = "left",
						["<down>"] = "down",
						["<up>"] = "up",
						["<right>"] = "right",
						["<S-left>"] = "far_left",
						["<S-down>"] = "far_down",
						["<S-up>"] = "far_up",
						["<S-right>"] = "far_right",
					},
				},
				---A function that should prompt the user to select a window.
				---
				---The window picker is used to select a window while swapping windows with
				---`:WinShift swap`.
				---@return integer? winid # Either the selected window ID, or `nil` to
				---   indicate that the user cancelled / gave an invalid selection.
				window_picker = function()
					return require("winshift.lib").pick_window({
						-- A string of chars used as identifiers by the window picker.
						picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						filter_rules = {
							-- This table allows you to indicate to the window picker that a window
							-- should be ignored if its buffer matches any of the following criteria.
							cur_win = true, -- Filter out the current window
							floats = true, -- Filter out floating windows
							filetype = { "lspsagaoutline", "Outline", "NvimTree" }, -- List of ignored file types
							buftype = {}, -- List of ignored buftypes
							bufname = {}, -- List of vim regex patterns matching ignored buffer names
						},
						---A function used to filter the list of selectable windows.
						---@param winids integer[] # The list of selectable window IDs.
						---@return integer[] filtered # The filtered list of window IDs.
						filter_func = nil,
					})
				end,
			})
			vim.cmd([[
					" Start Win-Move mode:
					nnoremap <C-W><C-M> <Cmd>WinShift<CR>
					nnoremap <C-W>m <Cmd>WinShift<CR>
					]])
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		enabled = not vim.g.__streaming,
		opts = { floating_window = true },
	},
	{
		"folke/noice.nvim",
		enabled = false,
		config = function()
			require("noice").setup({
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				lsp = {
					signature = {
						enabled = false,
					},
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		-- cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose", "NvimTreeRefresh", "NvimTreeOpen" },
		version = "*", -- optional, updated every week. (see issue #1193)
		init = function()
			vim.keymap.set("n", "<leader>ft", function()
				require("nvim-tree.api").tree.toggle({ focus = true, find_file = true })
			end, { noremap = true, silent = true })
		end,
		config = function()
			require("nvim-tree").setup({
				-- tab = {
				-- 	sync = {
				-- 		close = true,
				-- 	},
				-- },
			})
		end,
	},
	{
		"is0n/fm-nvim",
		config = function()
			vim.keymap.set("n", "<leader>fm", "<cmd>Lf<CR>", { noremap = true, silent = true })
			require("fm-nvim").setup({
				-- (Vim) Command used to open files
				edit_cmd = "edit",
				-- See `Q&A` for more info
				on_close = {},
				on_open = {},
				-- UI Options
				ui = {
					-- Default UI (can be "split" or "float")
					default = "float",
					float = {
						-- Floating window border (see ':h nvim_open_win')
						border = "rounded",
						-- Highlight group for floating window/border (see ':h winhl')
						float_hl = "Normal",
						border_hl = "FloatBorder",
						-- Floating Window Transparency (see ':h winblend')
						blend = 0,
						-- Num from 0 - 1 for measurements
						height = 0.8,
						width = 0.8,
						-- X and Y Axis of Window
						x = 0.5,
						y = 0.5,
					},
					split = {
						-- Direction of split
						direction = "topleft",
						-- Size of split
						size = 24,
					},
				},
				-- Terminal commands used w/ file manager (have to be in your $PATH)
				cmds = {
					lf_cmd = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
					fm_cmd = "fm",
					nnn_cmd = "nnn",
					fff_cmd = "fff",
					twf_cmd = "twf",
					fzf_cmd = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
					fzy_cmd = "find . | fzy",
					xplr_cmd = "xplr",
					vifm_cmd = "vifm",
					skim_cmd = "sk",
					broot_cmd = "broot",
					gitui_cmd = "gitui",
					ranger_cmd = "ranger",
					joshuto_cmd = "joshuto",
					lazygit_cmd = "lazygit",
					neomutt_cmd = "neomutt",
					taskwarrior_cmd = "taskwarrior-tui",
				},
				-- Mappings used with the plugin
				mappings = {
					vert_split = "<C-v>",
					horz_split = "<C-h>",
					tabedit = "<C-t>",
					edit = "<C-e>",
					ESC = "<ESC>",
				},
				-- Path to broot config
				broot_conf = vim.fn.stdpath("data") .. "/site/pack/packer/start/fm-nvim/assets/broot_conf.hjson",
			})
		end,
	},
	-- Lua
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		enabled = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	{
		"danymat/neogen",
		cmd = { "Neogen" },
		dependencies = "nvim-treesitter/nvim-treesitter",
		keys = {
			{
				"<leader>nff",
				function()
					require("neogen").generate({ type = "func" })
				end,
				desc = "Neogen Function",
			},
			{
				"<leader>nfc",
				function()
					require("neogen").generate({ type = "class" })
				end,
				desc = "Neogen Class",
			},
			{
				"<leader>nft",
				function()
					require("neogen").generate({ type = "type" })
				end,
				desc = "Neogen Type",
			},
		},
		opts = {
			snippet_engine = "luasnip",
		},
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
	{
		"glacambre/firenvim",
		enabled = false,
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end,
	},
	{ "LudoPinelli/comment-box.nvim" },
	{ "mbbill/undotree" },
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
		opts = {
			skipInsignificantPunctuation = false,
		},
		init = function()
			vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
			vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-w" })
			vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-w" })
			vim.keymap.set(
				{ "n", "o", "x" },
				"ge",
				"<cmd>lua require('spider').motion('ge')<CR>",
				{ desc = "Spider-w" }
			)
		end,
	},
	{ "axieax/typo.nvim", config = true },
	{ "stevearc/dressing.nvim", config = true },
	{
		"lvimuser/lsp-inlayhints.nvim",
		enabled = true,
		config = true,
	},
	{ "simrat39/rust-tools.nvim" },
	{
		"saecki/crates.nvim",
		-- branch = "v0.3.0",
		branch = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufRead Cargo.toml" },
		opts = {
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
		},
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		opts = { useDefaultKeymaps = true, disabledKeymaps = { "gc" } },
	},
	{
		"bennypowers/splitjoin.nvim",
		lazy = true,
		keys = {
			{
				"gj",
				function()
					require("splitjoin").join()
				end,
				desc = "Join the object under cursor",
			},
			{
				"g,",
				function()
					require("splitjoin").split()
				end,
				desc = "Split the object under cursor",
			},
		},
	},
	{
		"echasnovski/mini.cursorword",
		enabled = false,
		version = false,
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"glepnir/dashboard-nvim",
		enabled = false,
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"ms-jpq/coq_nvim",
		branch = "coq",
		enabled = false,
		config = function()
			vim.cmd([[COQnow --shut-up]])
		end,
	},
	{
		"ms-jpq/coq.artifacts",
		branch = "artifacts",
	},
	{
		"ms-jpq/coq.thirdparty",
		enabled = false,
		branch = "3p",
	},
	{
		"aperezdc/vim-template",
	},
	{
		"tpope/vim-abolish",
	},
	{
		"rest-nvim/rest.nvim",
		ft = { "http", "rest" },
		keys = {
			{ "<leader>rr", "<Plug>RestNvim", mode = { "n" }, desc = "Run HTTP Request" },
			{ "<leader>rl", "<Plug>RestNvimLast", mode = { "n" }, desc = "Run Last HTTP Request" },
			{ "<leader>rp", "<Plug>RestNvimPreview", mode = { "n" }, desc = "Preview HTTP Request" },
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					-- show the generated curl command in case you want to launch
					-- the same request via the terminal (can be verbose)
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
		end,
	},
	{
		"David-Kunz/gen.nvim",
		opts = {
			model = "stablelm2", -- The default model to use.
			host = "localhost", -- The host running the Ollama service.
			port = "11434", -- The port on which the Ollama service is listening.
			display_mode = "float", -- The display mode. Can be "float" or "split".
			show_prompt = true, -- Shows the Prompt submitted to Ollama.
			show_model = true, -- Displays which model you are using at the beginning of your chat session.
			no_auto_close = false, -- Never closes the window automatically.
			init = function() end,
			-- Function to initialize Ollama
			command = function(options)
				return "curl --silent --no-buffer -X POST http://"
					.. options.host
					.. ":"
					.. options.port
					.. "/api/chat -d $body"
			end,
			-- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
			-- This can also be a command string.
			-- The executed command must return a JSON object with { response, context }
			-- (context property is optional).
			-- list_models = '<omitted lua function>', -- Retrieves a list of model names
			debug = false, -- Prints errors and the command which is run.
		},
		keys = {
			{ "<leader>]", ":Gen<CR>", mode = { "n", "v" }, desc = "Gen AI" },
		},
	},
	{ "dmmulroy/ts-error-translator.nvim", config = true },
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
	{ "laytan/cloak.nvim", config = true },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = {} },
	{ "sainnhe/gruvbox-material" },
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			require("rainbow-delimiters.setup").setup({
				strategy = {
					-- ...
				},
				query = {
					-- ...
				},
				highlight = {
					-- ...
				},
			})
		end,
	},
})
