return {
	"olimorris/codecompanion.nvim",
	enabled = true,
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
		local vectorcode_integrations = pcall(require, "vectorcode.integrations")
		if vectorcode_integrations then
			ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
				strategies = {
					chat = {
						slash_commands = {
							codebase = require("vectorcode.integrations").codecompanion.chat.make_slash_command(),
						},
						tools = {
							vectorcode = {
								description = "Run VectorCode to retrieve the project context.",
								callback = require("vectorcode.integrations").codecompanion.chat.make_tool(),
							},
						},
					},
				},
			})
		end
		require("codecompanion").setup(ctx.opts)
		require("plugins.codecompanion.spinner"):init()
	end,
}
