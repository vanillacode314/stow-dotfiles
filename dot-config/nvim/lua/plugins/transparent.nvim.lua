return {
	"xiyaowong/nvim-transparent",
	enabled = false,
	config = function()
		require("transparent").setup({ -- Optional, you don't have to run setup.
			groups = { -- table: default groups
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				-- "CursorLine",
				-- "CursorLineNr",
				"StatusLine",
				"StatusLineNC",
				"EndOfBuffer",
				"WinBar",
				"WinBarNC",
				"WinSeparator",
				"TroubleNormal",
				"TroubleNormalNC",
				"lualine_b_normal",
				"lualine_b_inactive",
				"lualine_c_normal",
				"lualine_c_inactive",
				"lualine_y_normal",
				"lualine_y_inactive",
			},
			extra_groups = {}, -- table: additional groups that should be cleared
			exclude_groups = {}, -- table: groups you don't want to clear
		})
		require("transparent").clear_prefix("BufferLine")
		require("transparent").clear_prefix("DiagnosticSign")
		require("transparent").clear_prefix("DapUI")
		require("transparent").clear_prefix("lualine_y_filetype")
	end,
}
