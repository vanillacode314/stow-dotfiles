return {
	"chrisgrieser/nvim-chainsaw",
	event = "VeryLazy",
	opts = {}, -- required even if left empty
	config = function()
		local chainsaw = require("chainsaw")
		chainsaw.setup({})
		vim.keymap.set({ "n" }, "glj", chainsaw.variableLog)
	end,
}
