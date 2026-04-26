return {
	"pablopunk/pi.nvim",
	config = function()
		require("pi").setup({
			provider = "openrouter",
			model = "deepseek/deepseek-v4-flash",
			thinking = "off",
			system_prompt = "You are a helpful assistant.",
			append_system_prompt = "Always respond concisely.",
			context = {
				max_bytes = 24000,
				ask = {
					surrounding_lines = 80,
				},
				selection = {
					surrounding_lines = 40,
				},
			},
			skills = true,
			extensions = true,
		})
	end,
}
