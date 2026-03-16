return {
	"aweis89/ai-terminals.nvim",
	enabled = false,
	dependencies = { "folke/snacks.nvim" },
	opts = {
		backend = "tmux",
		terminals = {
			aider = { cmd = "aider" },
		},
		-- auto_terminal_keymaps = {
		-- 	prefix = "<leader>r",
		-- 	terminals = {
		-- 		{ name = "aider", key = "a" },
		-- 	},
		-- },
	},
	config = function(_, opts)
		require("ai-terminals").setup(opts)

		local ai = require("ai-terminals")

		-- Toggle terminal (sends visual selection if active)
		vim.keymap.set({ "n", "v" }, "<leader>r", function()
			ai.toggle("aider")
		end, { desc = "Aider: Toggle terminal" })

		-- Send diagnostics
		vim.keymap.set({ "n", "v" }, "<leader>rd", function()
			ai.send_diagnostics("aider")
		end, { desc = "Aider: Send diagnostics" })

		-- Add current file
		vim.keymap.set("n", "<leader>rl", function()
			ai.add_files_to_terminal("aider", { vim.fn.expand("%") })
		end, { desc = "Aider: Add current file" })

		-- Add all buffers
		vim.keymap.set("n", "<leader>rL", function()
			ai.add_buffers_to_terminal("aider")
		end, { desc = "Aider: Add all buffers" })

		-- Run command and send output
		vim.keymap.set("n", "<leader>rr", function()
			ai.send_command_output("aider")
		end, { desc = "Aider: Run command and send output" })

		-- Add comment for background execution
		vim.keymap.set("n", "<leader>rc", function()
			ai.comment("aider")
		end, { desc = "Aider: Add comment for AI to address" })
	end,
}
