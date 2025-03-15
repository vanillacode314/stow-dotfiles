return {
	{
		"David-Kunz/gen.nvim",
		opts = {
			model = "opencoder:1.5b", -- The default model to use.
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
		enabled = false,
		event = "VeryLazy",
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup({
				filetypes = {
					snacks_picker_input = false,
				},
			})
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
}
