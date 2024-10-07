vim.g.mapleader = " "
-- convert config to use lazy.nvim instead of packer.nvim
require("lazy").setup({
	require("plugins.treesitter"),
	require("plugins.ai"),
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
	{ "b0o/schemastore.nvim", event = "VeryLazy" },
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{ "lervag/vimtex", ft = { "latex", "tex" } },
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		-- version = 'release' -- To use the latest release
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"xiyaowong/nvim-transparent",
		enabled = false,
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
	{ "RRethy/nvim-base16", event = "VeryLazy" },
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		on_autoload_no_session = function() end,
		event = "VeryLazy",
		config = function()
			require("vscode").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
	},
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
	{ "booperlv/nvim-gomove", config = true, event = "VeryLazy" },
	{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", enabled = false, config = true },
	{ "onsails/lspkind-nvim", event = "VeryLazy" },
	{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" }, event = "VeryLazy" },
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
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight } })

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
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
		enabled = false,
		event = { "InsertEnter" },
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
			-- { "fivethree-team/vscode-svelte-snippets", ft = { "svelte" } },
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
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"lukas-reineke/cmp-rg",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			"jcha0713/cmp-tw2css",
			{
				"roobert/tailwindcss-colorizer-cmp.nvim",
				-- optionally, override the default options:
				config = function()
					require("tailwindcss-colorizer-cmp").setup({
						color_square_width = 2,
					})
				end,
			},
		},
		config = function()
			require("config.cmp")
		end,
	},

	{ "tzachar/cmp-tabnine", enabled = false, build = "./install.sh", dependencies = "hrsh7th/nvim-cmp" },
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
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
	},
	{ "wellle/targets.vim", event = "VeryLazy" },
	{
		"nvimdev/lspsaga.nvim",
		enabled = false,
		event = { "VeryLazy" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		branch = "main",
		config = function()
			local lspsaga = require("lspsaga")
			lspsaga.setup({
				ui = {
					-- border = false,
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
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({
				input_buffer_type = "dressing",
			})
			vim.keymap.set("n", "<leader>rn", ":IncRename ")
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
				char = {
					enabled = false,
					highlight = {
						backdrop = false,
					},
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
					return { "lsp", "indent" }
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
	-- {
	-- 	"Abstract-IDE/penvim",
	-- 	config = function()
	-- 		require("penvim").setup({
	-- 			rooter = {
	-- 				enable = true, -- enable/disable rooter
	-- 				--[[ patterns = { "pnpm-workspace.yaml", ".__nvim__.lua", ".git", "node_modules" }, ]]
	-- 			},
	-- 			indentor = {
	-- 				enable = true, -- enable/disable indentor
	-- 				indent_length = 2, -- tab indent width
	-- 				accuracy = 5, -- positive integer. higher the number, the more accurate result (but affects the startup time)
	-- 				disable_types = {
	-- 					"help",
	-- 					"dashboard",
	-- 					"dashpreview",
	-- 					"NvimTree",
	-- 					"vista",
	-- 					"sagahover",
	-- 					"terminal",
	-- 				},
	-- 			},
	-- 			project_env = {
	-- 				enable = true, -- enable/disable project_env
	-- 				--[[ config_name = ".__nvim__.lua", -- config file name ]]
	-- 			},
	-- 		})
	-- 	end,
	-- },
	require("plugins.trouble"),
	{
		"vimpostor/vim-tpipeline",
		enabled = false,
		config = function()
			vim.g.tpipeline_cursormoved = 1
		end,
	},
	require("plugins.telescope"),
	{
		"olimorris/persisted.nvim",
		lazy = false, -- make sure the plugin is always loaded at startup
		enabled = false,
		config = function()
			local persisted = require("persisted")
			persisted.setup({
				autostart = true, -- Automatically start the plugin on load?

				-- Function to determine if a session should be saved
				---@type fun() boolean
				should_save = function()
					return true
				end,

				save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- Directory where session files are saved

				follow_cwd = true, -- Change the session file to match any change in the cwd?
				use_git_branch = true, -- Include the git branch in the session file name?
				autoload = true, -- Automatically load the session for the cwd on Neovim startup?

				-- Function to run when `autoload = true` but there is no session to load
				---@type fun(): any
				on_autoload_no_session = function()
					vim.notify("No existing session to load.")
				end,

				allowed_dirs = {}, -- Table of dirs that the plugin will start and autoload from
				ignored_dirs = {}, -- Table of dirs that are ignored for starting and autoloading

				telescope = {
					mappings = { -- Mappings for managing sessions in Telescope
						copy_session = "<C-c>",
						change_branch = "<C-b>",
						delete_session = "<C-d>",
					},
					icons = { -- icons displayed in the Telescope picker
						selected = " ",
						dir = "  ",
						branch = " ",
					},
				},
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
		event = "VeryLazy",
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
	-- DAP
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>qc",
				function()
					require("dap").continue()
				end,
				mode = { "n" },
				desc = "Continue",
			},
			{
				"<leader>qs",
				function()
					require("dap").step_over()
				end,
				mode = { "n" },
				desc = "Step Over",
			},
			{
				"<leader>qi",
				function()
					require("dap").step_into()
				end,
				mode = { "n" },
				desc = "Step Into",
			},
			{
				"<leader>qo",
				function()
					require("dap").step_out()
				end,
				mode = { "n" },
				desc = "Step Out",
			},
			{
				"<leader>qb",
				function()
					require("dap").toggle_breakpoint()
				end,
				mode = { "n" },
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>qr",
				function()
					require("dap").restart()
				end,
				mode = { "n" },
				desc = "Restart",
			},
		},
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
	-- { "LiadOz/nvim-dap-repl-highlights", config = true },
	-- { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"jay-babu/mason-nvim-dap.nvim",
		cmd = { "DapInstall", "DapUninstall" },
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
	{ "theHamsta/nvim-dap-virtual-text", config = true, event = "VeryLazy" },
	-- { "sigmasd/deno-nvim", ft = { "typescript", "javascript" }, event = "VeryLazy" },
	{
		"rcarriga/nvim-dap-ui",
		event = { "VeryLazy" },
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
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
		config = function()
			require("config.mason")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("config.nullls")
			-- require("mason-null-ls").setup()
		end,
	},
	{
		"aserowy/tmux.nvim",
		event = "VeryLazy",
		config = function()
			return require("tmux").setup({
				copy_sync = {
					enabled = false,
				},
			})
		end,
	},
	{ "nvim-focus/focus.nvim", version = "*", opts = {}, enabled = false },
	{
		"sindrets/winshift.nvim",
		event = "VeryLazy",
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
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeClose", "NvimTreeRefresh", "NvimTreeOpen" },
		keys = {
			{
				"<leader>ft",
				function()
					require("nvim-tree.api").tree.toggle({ focus = true, find_file = true })
				end,
				desc = "Toggle NvimTree",
				mode = { "n" },
				noremap = true,
				silent = true,
			},
		},
		version = "*", -- optional, updated every week. (see issue #1193)
		opts = {
			-- tab = {
			-- 	sync = {
			-- 		close = true,
			-- 	},
			-- },
		},
	},
	{
		"is0n/fm-nvim",
		event = "VeryLazy",
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
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
	},
	{
		enabled = false,
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
			snippet_engine = "nvim",
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
	{ "LudoPinelli/comment-box.nvim", event = "VeryLazy" },
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
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
	-- { "axieax/typo.nvim", config = true },
	{ "stevearc/dressing.nvim", config = true, event = "VeryLazy" },
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
		"tpope/vim-abolish",
		event = "CmdlineEnter",
	},
	{
		"tpope/vim-eunuch",
		event = "CmdlineEnter",
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
	-- { "dmmulroy/ts-error-translator.nvim", config = true },
	{ "laytan/cloak.nvim", config = true },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = {}, event = "ColorScheme" },
	{ "sainnhe/gruvbox-material", event = "ColorScheme" },
	{
		"HiPhish/rainbow-delimiters.nvim",
		-- event = "VeryLazy",
		config = function()
			require("rainbow-delimiters.setup").setup({})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					yaml = { "yamlfmt" },
					-- Conform will run multiple formatters sequentially
					python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
					-- Use a sub-list to run only the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					svelte = { "prettierd", "prettier", stop_after_first = true },
					vue = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					proto = { "buf" },
					javacsriptreact = { "prettierd", "prettier", stop_after_first = true },
					sql = { "sql_formatter" },
					json = { "jq" },
					jsonc = { "prettierd", "prettier", stop_after_first = true },
					bash = { "shfmt" },
					sh = { "shfmt" },
					fish = { "fish_indent" },
					rust = { "rustfmt" },
					nix = { "nixfmt" },
					["*"] = { "injected" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
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
		event = "BufEnter",
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
					on_attach = function(client, bufnr)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
						require("config.lsp").on_attach(client, bufnr)
					end,
					handlers = require("config.lsp").handlers,
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
	{
		"pmizio/typescript-tools.nvim",
		enabled = false,
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	{
		"m4xshen/hardtime.nvim",
		-- event = "VeryLazy",
		-- enabled = false,
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disabled_filetypes = {
				"trouble",
				"qf",
				"netrw",
				"NvimTree",
				"lazy",
				"mason",
				"oil",
				"tsplayground",
				"TelescopePrompt",
			},
		},
	},
	{
		"olrtg/nvim-emmet",
		keys = {
			{
				"<leader>xe",
				function()
					require("nvim-emmet").expand_abbreviation()
				end,
				mode = { "n", "v" },
				desc = "Emmet Expand Abbreviation",
			},
		},
	},
	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		priority = 100,
		config = function()
			require("project_nvim").setup({})
			-- vim.api.nvim_create_autocmd("DirChanged", {
			-- 	group = vim.api.nvim_create_augroup("Project", { clear = true }),
			-- 	callback = function()
			-- 		vim.cmd([[SessionRestore]])
			-- 	end,
			-- })
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		-- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	},
	{
		"miroshQa/rittli.nvim",
		lazy = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		-- keys = {
		-- 	{
		-- 		"<C-t>",
		-- 		function()
		-- 			require("rittli.terminal_tweaks").toggle_last_openned_terminal()
		-- 		end,
		-- 		mode = { "n", "t" },
		-- 	},
		-- 	{ "<Esc><Esc>", "<C-\\><C-n>", mode = "t" },
		-- 	{
		-- 		"<leader>r",
		-- 		function()
		-- 			require("rittli.tasks.telescope").run_last_runned_task()
		-- 		end,
		-- 		desc = "Rerun the last task or pick a new one",
		-- 	},
		-- 	{
		-- 		"<leader>R",
		-- 		function()
		-- 			require("rittli.tasks.telescope").tasks_picker()
		-- 		end,
		-- 		desc = "Pick the task",
		-- 	},
		-- 	{
		-- 		"<leader><leader>",
		-- 		function()
		-- 			require("telescope.builtin").buffers({
		-- 				path_display = { "tail" },
		-- 				sort_mru = true,
		-- 				ignore_current_buffer = true,
		-- 			})
		-- 		end,
		-- 	},
		-- },
		---@type Rittli.Config
		opts = {},
	},
	-- {
	-- 	"EtiamNullam/fold-ribbon.nvim",
	-- 	config = function()
	-- 		require("fold-ribbon").setup({
	-- 			highlight_steps = {
	-- 				{ bg = "#ff8888" },
	-- 				{ bg = "#88ff88" },
	-- 				{ bg = "#8888ff" },
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"ptdewey/pendulum-nvim",
		config = function()
			require("pendulum").setup()
		end,
	},
	{ "tpope/vim-fugitive" },
	require("plugins.diffview"),
	{ "isobit/vim-caddyfile", ft = "caddyflie" },
	{ "marilari88/twoslash-queries.nvim" },
})
