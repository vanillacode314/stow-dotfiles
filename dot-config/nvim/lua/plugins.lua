return {
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "b0o/schemastore.nvim", event = "VeryLazy" },
	{ "lervag/vimtex", ft = { "latex", "tex" } },
	{ "RRethy/nvim-base16", event = "VeryLazy" },
	{ "Mofiqul/vscode.nvim", event = "ColorScheme" },
	{ "askfiy/visual_studio_code", event = "ColorScheme" },
	{
		"rockyzhang24/arctic.nvim",
		branch = "v2",
		priority = 100,
		dependencies = { "rktjmp/lush.nvim" },
		event = "ColorScheme",
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
	},
	{
		"folke/zen-mode.nvim",
		enabled = true,
		cmd = { "ZenMode" },
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
		},
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
	{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" }, event = "VeryLazy" },
	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		config = function()
			require("config.lualine")
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
	{ "wellle/targets.vim", event = "VeryLazy" },
	{
		"smjonas/inc-rename.nvim",
		enabled = false,
		config = function()
			require("inc_rename").setup({
				input_buffer_type = "dressing",
			})
			vim.keymap.set("n", "<leader>rn", ":IncRename ")
		end,
	},

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
		"kevinhwang91/nvim-ufo",
		event = { "VeryLazy" },
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
						-- str width returned from truncate() may less than 2nd argument, need padding
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
		"folke/which-key.nvim",
		enabled = true,
		opts = {
			triggers = { "<Space>" },
		},
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
	{
		"gorbit99/codewindow.nvim",
		config = true,
		keys = {
			{
				"<leader>mo",
				function()
					require("codewindow").open_minimap()
				end,
				mode = { "n" },
				desc = "Open minimap",
			},
			{
				"<leader>mf",
				function()
					require("codewindow").toggle_focus()
				end,
				mode = { "n" },
				desc = "Toggle minimap focus",
			},
			{
				"<leader>mc",
				function()
					require("codewindow").close_minimap()
				end,
				mode = { "n" },
				desc = "Close minimap",
			},
			{
				"<leader>mm",
				function()
					require("codewindow").toggle_minimap()
				end,
				mode = { "n" },
				desc = "Toggle minimap",
			},
		},
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
			"mason-org/mason.nvim",
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
	-- Lua
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
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
		"tpope/vim-abolish",
		event = "CmdlineEnter",
	},
	{
		"tpope/vim-eunuch",
		event = "CmdlineEnter",
	},
	-- { "dmmulroy/ts-error-translator.nvim", config = true },
	{ "laytan/cloak.nvim", config = true },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = {}, event = "ColorScheme" },
	{ "sainnhe/gruvbox-material", event = "ColorScheme" },
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "FileType",
		config = function()
			require("rainbow-delimiters.setup").setup({})
		end,
	},
	{
		enabled = false,
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
		lazy = false,
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
		"pmizio/typescript-tools.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		enabled = true,
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
		config = function(ctx)
			ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
				on_attach = function(client, bufnr)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					require("config.lsp").on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("TypescriptToolsBufWritePre", { clear = true }),
						callback = function()
							vim.cmd("TSToolsAddMissingImports")
						end,
					})
				end,
				capabilities = require("config.lsp").capabilities,
			})
			require("typescript-tools").setup(ctx.opts)
		end,
	},
	{
		"chrisgrieser/nvim-lsp-endhints",
		event = "LspAttach",
		opts = {}, -- required, even if empty
	},
	{
		"m4xshen/hardtime.nvim",
		event = "BufReadPost",
		enabled = true,
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			disabled_filetypes = {
				"snacks_dashboard",
				"Codewindow",
				"codecompanion",
				"trouble",
				"qf",
				"netrw",
				"NvimTree",
				"lazy",
				"mason",
				"mcphub",
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
					require("nvim-emmet").wrap_with_abbreviation()
				end,
				mode = { "n", "v" },
				desc = "Emmet Wrap With Abbreviation",
			},
		},
	},
	{ "notjedi/nvim-rooter.lua", config = true },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		ft = { "markdown", "codecompanion", "Avante" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	},
	{ "ptdewey/pendulum-nvim", config = true },
	-- { "tpope/vim-fugitive" },
	{ "isobit/vim-caddyfile", ft = "caddyflie" },
	{ "sitiom/nvim-numbertoggle", event = "InsertEnter" },
	{ "andis-sprinkis/lf-vim", event = { "BufReadPre lfrc" } },
	{ "sontungexpt/better-diagnostic-virtual-text", lazy = true },
	{ "folke/ts-comments.nvim", opts = {}, event = "VeryLazy" },
	{ "echasnovski/mini.icons", version = false },
	{
		"Bekaboo/dropbar.nvim",
		event = "VeryLazy",
		config = function()
			require("dropbar").setup({
				bar = {
					enable = function(buf, win, _)
						if
							not vim.api.nvim_buf_is_valid(buf)
							or not vim.api.nvim_win_is_valid(win)
							or vim.fn.win_gettype(win) ~= ""
							or vim.wo[win].winbar ~= ""
							or vim.bo[buf].ft == "help"
							or vim.bo[buf].ft == "codecompanion"
						then
							return false
						end

						local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
						if stat and stat.size > 1024 * 1024 then
							return false
						end

						return vim.bo[buf].ft == "markdown"
							or pcall(vim.treesitter.get_parser, buf)
							or not vim.tbl_isempty(vim.lsp.get_clients({
								bufnr = buf,
								method = "textDocument/documentSymbol",
							}))
					end,
				},
			})
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
}
