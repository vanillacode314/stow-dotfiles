vim.g.mapleader = " "
-- convert config to use lazy.nvim instead of packer.nvim
require("lazy").setup({
	require("plugins.treesitter"),
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
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
					-- "CursorLine",
					-- "CursorLineNr",
					"StatusLine",
					"StatusLineNC",
					"EndOfBuffer",
					"WinBar",
					"WinBarNC",
					"WinSeparator",
					"TroubleNormal",
					"TroubleNormalNC",
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
			require("transparent").clear_prefix("BufferLine")
			require("transparent").clear_prefix("DiagnosticSign")
			require("transparent").clear_prefix("DapUI")
			require("transparent").clear_prefix("lualine_y_filetype")
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
	{ "booperlv/nvim-gomove", config = true },
	{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", enabled = false, config = true },
	{ "onsails/lspkind-nvim" },
	{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
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
		"garymjr/nvim-snippets",
		config = function()
			require("snippets").setup({
				extended_filetypes = {
					typescript = { "javascript" },
					typescriptreact = {
						"javascript",
						"javascriptreact",
					},
					javascriptreact = { "javascript" },
				},
				create_cmp_source = true,
				friendly_snippets = true,
				search_paths = { vim.fn.stdpath("config") .. "/snippets" },
			})
		end,
		dependencies = {
			{ "fivethree-team/vscode-svelte-snippets", ft = { "svelte" } },
			{ "solidjs-community/solid-snippets", ft = { "html", "typescriptreact" } },
			"rafamadriz/friendly-snippets",
			{ "sdras/vue-vscode-snippets", ft = { "vue" } },
		},
	},
	-- {
	-- 	"L3MON4D3/LuaSnip",
	-- 	config = function()
	-- 		require("config.snippets")
	-- 		require("luasnip.loaders.from_snipmate").lazy_load()
	-- 		require("luasnip.loaders.from_vscode").lazy_load()
	-- 	end,
	-- },
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
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
		dependencies = {
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				config = function()
					require("ts_context_commentstring").setup({
						enable_autocmd = false,
					})
				end,
			},
		},
		lazy = false,
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
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				chars = {
					enabled = false,
				},
			},
		},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({})
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		enabled = false,
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
					return { "treesitten", "indent" }
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
	-- "jose-elias-alvarez/typescript.nvim",
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
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		-- config = function()
		-- 	require("trouble").setup({})
		-- 	local opts = { silent = true, noremap = true }
		-- 	vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
		-- 	vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
		-- 	vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo<cr>", opts)
		-- 	vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
		-- 	vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
		-- 	vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
		-- 	vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
		-- end,
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
						vim_diff_opts = { ctxlen = 999 },
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
			vim.keymap.set("n", "<leader>qc", dap.continue)
			vim.keymap.set("n", "<leader>qs", dap.step_over)
			vim.keymap.set("n", "<leader>qi", dap.step_into)
			vim.keymap.set("n", "<leader>qo", dap.step_out)
			vim.keymap.set("n", "<leader>qb", dap.toggle_breakpoint)
			vim.keymap.set("n", "<leader>qr", dap.restart)

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
	{ "LiadOz/nvim-dap-repl-highlights", config = true },
	-- { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				automatic_installation = false,
				ensure_installed = { "firefox", "python" },
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
					firefox = function(config)
						config.configurations = {
							{
								name = "Debug with Firefox",
								type = "firefox",
								request = "launch",
								reAttach = true,
								url = "http://localhost:5173",
								webRoot = "${workspaceFolder}",
								firefoxExecutable = "/usr/bin/firefox",
							},
						}
						config.filetypes =
							{ "javascriptreact", "typescriptreact", "typescript", "javascript", "svelte", "astro" }
						require("mason-nvim-dap").default_setup(config) -- don't forget this!
					end,
				},
			})
		end,
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
	},
	{ "theHamsta/nvim-dap-virtual-text", config = true },
	{ "sigmasd/deno-nvim" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
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
	{ "nvim-focus/focus.nvim", version = "*", opts = {} },
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
		enabled = false,
		opts = { floating_window = false },
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
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
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
		event = "UIEnter",
		config = function()
			require("various-textobjs").setup({
				{ useDefaultKeymaps = true, disabledKeymaps = { "gc" } },
			})
			vim.keymap.set("n", "dsi", function()
				-- select outer indentation
				require("various-textobjs").indentation("outer", "outer")

				-- plugin only switches to visual mode when a textobj has been found
				local indentationFound = vim.fn.mode():find("V")
				if not indentationFound then
					return
				end

				-- dedent indentation
				vim.cmd.normal({ "<", bang = true })

				-- delete surrounding lines
				local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
				local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
				vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
				vim.cmd(tostring(startBorderLn) .. " delete")
			end, { desc = "Delete Surrounding Indentation" })
			vim.keymap.set("n", "ysii", function()
				local startPos = vim.api.nvim_win_get_cursor(0)

				-- identify start- and end-border
				require("various-textobjs").indentation("outer", "outer")
				local indentationFound = vim.fn.mode():find("V")
				if not indentationFound then
					return
				end
				vim.cmd.normal({ "V", bang = true }) -- leave visual mode so the '< '> marks are set

				-- copy them into the + register
				local startLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
				local endLn = vim.api.nvim_buf_get_mark(0, ">")[1] - 1
				local startLine = vim.api.nvim_buf_get_lines(0, startLn, startLn + 1, false)[1]
				local endLine = vim.api.nvim_buf_get_lines(0, endLn, endLn + 1, false)[1]
				vim.fn.setreg("+", startLine .. "\n" .. endLine .. "\n")

				-- highlight yanked text
				local ns = vim.api.nvim_create_namespace("ysi")
				vim.api.nvim_buf_add_highlight(0, ns, "IncSearch", startLn, 0, -1)
				vim.api.nvim_buf_add_highlight(0, ns, "IncSearch", endLn, 0, -1)
				vim.defer_fn(function()
					vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
				end, 1000)

				-- restore cursor position
				vim.api.nvim_win_set_cursor(0, startPos)
			end, { desc = "Yank surrounding indentation" })
		end,
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
		enabled = false,
		ft = { "http", "rest" },
		keys = {
			{ "<leader>rr", "<Plug>RestNvim", mode = { "n" }, desc = "Run HTTP Request" },
			{ "<leader>rl", "<Plug>RestNvimLast", mode = { "n" }, desc = "Run Last HTTP Request" },
			{ "<leader>rp", "<Plug>RestNvimPreview", mode = { "n" }, desc = "Preview HTTP Request" },
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("rest-nvim").setup()
		end,
	},
	{
		"David-Kunz/gen.nvim",
		opts = {
			model = "llama3", -- The default model to use.
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
	-- { "dmmulroy/ts-error-translator.nvim", config = true },
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
			require("rainbow-delimiters.setup").setup({})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					yaml = { "yamlfmt" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "black" },
					-- Use a sub-list to run only the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					proto = { "buf" },
					javacsriptreact = { "prettierd", "prettier", stop_after_first = true },
					sql = { "sql_formatter" },
					json = { "jq" },
					bash = { "shfmt" },
					sh = { "shfmt" },
					fish = { "fish_indent" },
					nix = { "nixfmt" },
					["*"] = { "injected" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
			require("conform").formatters.sql_formatter = {
				prepend_args = { "-c", vim.fn.expand("~/.config/sql-formatter.json") },
			}
		end,
	},
	{
		"Dronakurl/injectme.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		-- This is for lazy load and more performance on startup only
		cmd = { "InjectmeToggle", "InjectmeSave", "InjectmeInfo", "InjectmeLeave" },
	},
	"kovetskiy/sxhkd-vim",
	-- { "tenxsoydev/karen-yank.nvim", config = true },
	-- {
	-- 	"otavioschwanck/arrow.nvim",
	-- 	opts = {
	-- 		show_icons = true,
	-- 		leader_key = ";", -- Recommended to be a single key
	-- 		buffer_leader_key = "m", -- Per Buffer Mappings
	-- 	},
	-- },
	{
		"yamatsum/nvim-cursorline",
		opts = {
			cursorline = {
				enable = false,
				timeout = 1000,
				number = false,
			},
			cursorword = {
				enable = true,
				min_length = 3,
				hl = { underline = true },
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		init = function()
			local function on_attach(noformat)
				return function(client, bufnr)
					if noformat then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
					require("config.lsp").on_attach(client, bufnr)
				end
			end
			vim.g.rustaceanvim = {
				server = {
					on_attach = on_attach(true),
					default_settings = {
						["rust-analyzer"] = {
							inlayHints = {
								bindingModeHints = {
									enable = false,
								},
								chainingHints = {
									enable = true,
								},
								closingBraceHints = {
									enable = true,
									minLines = 25,
								},
								closureReturnTypeHints = {
									enable = "never",
								},
								lifetimeElisionHints = {
									enable = "never",
									useParameterNames = false,
								},
								maxLength = 25,
								parameterHints = {
									enable = true,
								},
								reborrowHints = {
									enable = "never",
								},
								renderColons = true,
								typeHints = {
									enable = true,
									hideClosureInitialization = false,
									hideNamedConstructor = false,
								},
							},
						},
					},
				},
			}
		end,
		lazy = false, -- This plugin is already lazy
	},
	{
		"andrewferrier/debugprint.nvim",
		opts = {},
		dependencies = {
			"echasnovski/mini.nvim", -- Needed for :ToggleCommentDebugPrints (not needed for NeoVim 0.10+)
		},
		-- The 'keys' and 'cmds' sections of this configuration are optional and only needed if
		-- you want to take advantage of `lazy.nvim` lazy-loading. If you decide to
		-- customize the keys/commands (see below), you'll need to change these too.
		keys = {
			{ "g?", mode = "n" },
			{ "g?", mode = "x" },
		},
		cmd = {
			"ToggleCommentDebugPrints",
			"DeleteDebugPrints",
		},
	},
	{
		"mistweaverco/kulala.nvim",
		filetype = { "http" },
		keys = {
			{
				"<leader>kr",
				function()
					require("kulala").run()
				end,
				desc = "Kulala Run",
				noremap = true,
				silent = true,
			},
			{
				"<leader>kn",
				function()
					require("kulala").jump_next()
				end,
				desc = "Kulala Jump Next",
				noremap = true,
				silent = true,
			},
			{
				"<leader>kp",
				function()
					require("kulala").jump_prev()
				end,
				desc = "Kulala Jump Prev",
				noremap = true,
				silent = true,
			},
			{
				"<leader>ks",
				function()
					require("kulala").scratchpad()
				end,
				desc = "Kulala Scratchpad",
				noremap = true,
				silent = true,
			},
		},
		config = function()
			require("kulala").setup()
		end,
	},
	{
		"m-gail/escape.nvim",
		keys = {
			{
				"<leader>ke",
				function()
					require("escape").escape()
				end,
				mode = { "x", "v" },
				desc = "Escape String",
				noremap = true,
			},
		},
	},
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("inlay-hints").setup()
		end,
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {
	-- 		settings = {
	-- 			tsserver_file_preferences = {
	-- 				includeInlayParameterNameHints = "all",
	-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	-- 				includeInlayFunctionParameterTypeHints = true,
	-- 				includeInlayVariableTypeHints = true,
	-- 				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	-- 				includeInlayPropertyDeclarationTypeHints = true,
	-- 				includeInlayFunctionLikeReturnTypeHints = true,
	-- 				includeInlayEnumMemberValueHints = true,
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	{
		"m4xshen/hardtime.nvim",
		-- enabled = false,
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
		end,
	},
})
