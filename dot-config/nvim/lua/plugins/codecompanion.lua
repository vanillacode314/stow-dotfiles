return {
	"olimorris/codecompanion.nvim",
	enabled = true,
	event = { "VeryLazy" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
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
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					schema = {
						model = {
							default = "gemini-2.5-flash-preview-04-17",
						},
					},
				})
			end,
			["groq"] = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					name = "groq",
					formatted_name = "Groq",
					env = {
						url = "https://api.groq.com/openai",
						api_key = "GROQ_API_KEY",
					},
					schema = {
						model = {
							default = "qwen-qwq-32b",
						},
					},
				})
			end,
			["openrouter"] = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					name = "openrouter",
					formatted_name = "OpenRouter",
					env = {
						url = "https://openrouter.ai/api",
						api_key = "OPENROUTER_API_KEY",
					},
					schema = {
						model = {
							default = "deepseek/deepseek-r1:free",
						},
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
				window = {
					layout = "vertical",
					width = 0.3,
				},
			},
			diff = {
				enabled = true,
				close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
				layout = "vertical", -- vertical|horizontal split for default provider
				opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
				provider = "mini_diff", -- default|mini_diff
			},
		},
	},
	init = function()
		vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.keymap.set(
			{ "n", "v" },
			"<leader>a",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
	config = function(ctx)
		require("plugins.codecompanion.mcphub-nvim"):init(ctx)
		require("plugins.codecompanion.vectorcode"):init(ctx)

		local prompts = {
			"smart-paste",
			"vibe-code",
		}
		for _, prompt in ipairs(prompts) do
			require("plugins.codecompanion.prompts." .. prompt):init(ctx)
		end
		require("plugins.codecompanion.spinner"):init()
		require("codecompanion").setup(ctx.opts)
	end,
}
