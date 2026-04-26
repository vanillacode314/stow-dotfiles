return {
	"olimorris/codecompanion.nvim",
	enabled = false,
	event = { "VeryLazy" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ravitemer/codecompanion-history.nvim",
	},
	opts = {
		-- opts = {
		-- 	log_level = "DEBUG", -- or "TRACE"
		-- },
		extensions = {
			history = {
				enabled = false,
				opts = {
					-- Keymap to open history from chat buffer (default: gh)
					keymap = "gh",
					-- Automatically generate titles for new chats
					auto_generate_title = false,
					---On exiting and entering neovim, loads the last chat on opening chat
					continue_last_chat = false,
					---When chat is cleared with `gx` delete the chat from history
					delete_on_clearing_chat = false,
					-- Picker interface ("telescope", "snacks" or "default")
					picker = "snacks",
					---Enable detailed logging for history extension
					enable_logging = false,
					---Directory path to save the chats
					dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
					-- Save all chats by default
					auto_save = false,
					-- Keymap to save the current chat manually
					save_chat_keymap = "sc",
				},
			},
		},
		adapters = {
			http = {
				["llama-swap"] = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						name = "llama-swap",
						formatted_name = "LlamaSwap",
						schema = {
							model = {
								default = "gemma-3-4b",
							},
						},
						env = {
							url = "http://localhost:6003",
							api_key = "TERM",
						},
						handlers = {
							inline_output = function(self, data)
								local openai = require("codecompanion.adapters.http.openai")
								return openai.handlers.inline_output(self, data)
							end,
							chat_output = function(self, data)
								local openai = require("codecompanion.adapters.http.openai")
								local result = openai.handlers.chat_output(self, data)
								if result ~= nil then
									result.output.role = "assistant"
								end
								return result
							end,
						},
					})
				end,
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = {
								default = "gemini-3-flash-preview",
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
								default = "openai/gpt-oss-120b",
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
								default = "deepseek/deepseek-v3.2",
							},
						},
					})
				end,
			},
		},
		prompt_library = {
			["Deepthinking"] = {
				strategy = "chat",
				opts = {
					is_slash_cmd = true,
					short_name = "deepthink",
					ignore_system_prompt = true,
				},
				prompts = {
					{
						role = "system",
						content = "Enable deepthinking subroutine.",
					},
				},
			},
		},
		strategies = {
			chat = {
				adapter = "openrouter",
				tools = {
					opts = {
						default_tools = {
							-- "basic_memory",
							-- "searxng",
						},
					},
				},
			},
			inline = {
				adapter = "openrouter",
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
				provider = "mini_diff", -- mini_diff|split|inline

				provider_opts = {
					opts = {
						context_lines = 3, -- Number of context lines in hunks
						dim = 25, -- Background dim level for floating diff (0-100, [100 full transparent], only applies when layout = "float")
						full_width_removed = true, -- Make removed lines span full width
						show_keymap_hints = true, -- Show "gda: accept | gdr: reject" hints above diff
						show_removed = true, -- Show removed lines as virtual text
					},
				},
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
			"fix-diagnostics",
		}
		for _, prompt in ipairs(prompts) do
			local mod = require("plugins.codecompanion.prompts." .. prompt)
			ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
				prompt_library = { [mod.name] = mod.prompt },
			})
		end
		require("plugins.codecompanion.spinner"):init()
		require("codecompanion").setup(ctx.opts)
	end,
}
