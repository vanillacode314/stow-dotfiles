return {
	"olimorris/codecompanion.nvim",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
		"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
		-- { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
	},

	opts = {
		-- opts = {
		-- 	log_level = "DEBUG", -- or "TRACE"
		-- },
		adapters = {
			llama = function()
				return require("codecompanion.adapters").extend("ollama", {
					name = "llama",
					schema = {
						model = {
							default = "deepseek-r1",
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
				adapter = "gemini",
			},
			inline = {
				adapter = "gemini",
			},
			agent = {
				adapter = "gemini",
			},
		},
		display = {
			chat = {
				diff = {
					enabled = true,
					close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
					layout = "vertical", -- vertical|horizontal split for default provider
					opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
					provider = "mini_diff", -- default|mini_diff
				},
			},
		},
	},
	init = function()
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
