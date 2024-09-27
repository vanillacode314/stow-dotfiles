return {
	{
		"David-Kunz/gen.nvim",
		opts = {
			model = "qwen2.5-coder", -- The default model to use.
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
	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup()
			vim.keymap.set("i", "<C-j>", neocodeium.accept)
			vim.keymap.set("i", "<c-;>", function()
				neocodeium.cycle(1)
			end)
			vim.keymap.set("i", "<c-,>", function()
				neocodeium.cycle(-1)
			end)
			vim.keymap.set("i", "<c-x>", neocodeium.clear)
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
			"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
			-- { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
		},
		config = function()
			vim.cmd([[cab cc CodeCompanion]])
			require("codecompanion").setup({
				-- opts = {
				-- 	log_level = "DEBUG", -- or "TRACE"
				-- },
				adapters = {
					llama = function()
						return require("codecompanion.adapters").extend("ollama", {
							name = "llama",
							schema = {
								model = {
									default = "qwen2.5-coder",
								},
								num_ctx = {
									default = 16384,
								},
								num_predict = {
									default = -1,
								},
							},
							env = {
								url = "http://localhost:11434",
								-- api_key = "OLLAMA_API_KEY",
							},
							headers = {
								["Content-Type"] = "application/json",
								-- ["Authorization"] = "Bearer ${api_key}",
							},
							parameters = {
								sync = true,
							},
						})
					end,
				},
				strategies = {
					chat = {
						adapter = "llama",
					},
					inline = {
						adapter = "llama",
					},
					agent = {
						adapter = "llama",
					},
				},
			})
		end,
	},
}
