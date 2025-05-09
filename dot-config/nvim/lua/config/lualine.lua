-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.black, bg = colors.violet },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.white },
	},

	insert = { a = { fg = colors.black, bg = colors.blue } },
	visual = { a = { fg = colors.black, bg = colors.cyan } },
	replace = { a = { fg = colors.black, bg = colors.red } },

	inactive = {
		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white },
	},
}

require("lualine").setup({
	options = {
		theme = bubbles_theme,
		component_separators = "",
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "", right = "" } } },
		lualine_b = {
			{ "filename", separator = { left = "", right = "" } },
			{ "branch", separator = { left = "", right = "" } },
		},
		lualine_c = {
			{
				"diagnostics",

				-- Table of diagnostic sources, available sources are:
				--   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
				-- or a function that returns a table as such:
				--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
				sources = { "nvim_diagnostic" },

				-- Displays diagnostics for the defined severity types
				sections = { "error", "warn", "info", "hint" },

				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = "DiagnosticError", -- Changes diagnostics' error color.
					warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
					info = "DiagnosticInfo", -- Changes diagnostics' info color.
					hint = "DiagnosticHint", -- Changes diagnostics' hint color.
				},
				symbols = { error = "E", warn = "W", info = "I", hint = "H" },
				colored = true, -- Displays diagnostics status in color if set to true.
				update_in_insert = false, -- Update diagnostics in insert mode.
				always_visible = false, -- Show diagnostics even if there are none.
				separator = { right = "" },
			},
			{
				function()
					local statusline = require("arrow.statusline")
					return statusline.text_for_statusline_with_icons() -- Same, but with an bow and arrow icon ;D
				end,
			},
		},
		lualine_x = {
			{
				function()
					return require("mcphub.extensions.lualine")
				end,
			},
		},
		lualine_y = {
			{
				function()
					return require("vectorcode.integrations").lualine(opts)[1]()
				end,
				separator = { left = "", right = "" },
				cond = function()
					if package.loaded["vectorcode"] == nil then
						return false
					else
						return require("vectorcode.integrations").lualine(opts).cond()
					end
				end,
			},
			{
				function()
					local retval = ""
					for index, value in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if index > 1 then
							retval = retval .. " "
						end
						retval = retval .. value.name
					end
					return retval
				end,
				separator = { left = "", right = "" },
			},
			{
				"filetype",
				separator = { left = "", right = "" },
			},
			"progress",
		},
		lualine_z = {
			{ "location", separator = { left = "", right = "" } },
		},
	},
	inactive_sections = {
		lualine_a = {
			{ "filename", separator = { left = "", right = "" } },
			{ "branch", separator = { left = "", right = "" } },
		},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {
			{ "location", separator = { left = "", right = "" } },
		},
	},
	-- tabline = {
	-- 	lualine_a = { { "buffers", separator = { left = "", right = "" } } },
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = { { "tabs", separator = { left = "", right = "" } } },
	-- },
	winbar = {},
	extensions = {
		"nvim-tree",
		"trouble",
		"mason",
		"lazy",
		"symbols-outline",
		"nvim-dap-ui",
		"fugitive",
		"fzf",
		"quickfix",
	},
})
