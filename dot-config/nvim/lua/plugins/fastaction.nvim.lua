return {
	"Chaitanyabsprip/fastaction.nvim",
	---@type FastActionConfig
	opts = {
		dismiss_keys = { "j", "k", "<c-c>", "q" },
		override_function = function(_) end,
		keys = "qwertyuiopasdfghlzxcvbnm",
		popup = {
			border = "rounded",
			hide_cursor = true,
			highlight = {
				divider = "FloatBorder",
				key = "MoreMsg",
				title = "Title",
				window = "NormalFloat",
			},
			title = "Select one of:",
		},
		priority = {
			-- dart = {
			--   { pattern = "organize import", key ="o", order = 1 },
			--   { pattern = "extract method", key ="x", order = 2 },
			--   { pattern = "extract widget", key ="e", order = 3 },
			-- },
		},
		register_ui_select = false,
		format_right_section = nil,
	},
}
