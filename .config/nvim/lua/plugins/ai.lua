return {
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
