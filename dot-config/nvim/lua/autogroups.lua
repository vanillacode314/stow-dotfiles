vim.api.nvim_create_augroup("mygroup", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "mygroup",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("HighlightChanges", { clear = true }),
	callback = function()
		local LineNrHighlight = vim.api.nvim_get_hl(0, { name = "LineNr" })
		local NormalHighlight = vim.api.nvim_get_hl(0, { name = "Normal" })
		local VisualHighlight = vim.api.nvim_get_hl(0, { name = "Visual" })
		local TSAttributeHighlight = vim.api.nvim_get_hl(0, { name = "TSAttribute" })

		vim.api.nvim_set_hl(0, "TelescopeBorder", vim.tbl_extend("force", LineNrHighlight, { bg = nil }))
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", vim.tbl_extend("force", LineNrHighlight, { bg = nil }))
		vim.api.nvim_set_hl(0, "TelescopeNormal", vim.tbl_extend("force", NormalHighlight, { bg = nil }))
		vim.api.nvim_set_hl(0, "TelescopePromptNormal", vim.tbl_extend("force", NormalHighlight, { bg = nil }))
		vim.api.nvim_set_hl(
			0,
			"TelescopePromptPrefix",
			vim.tbl_extend("force", NormalHighlight, { fg = TSAttributeHighlight.fg })
		)
		vim.api.nvim_set_hl(0, "TelescopeSelection", vim.tbl_extend("force", VisualHighlight, {}))
		vim.cmd([[
				" highlight Normal guibg=None ctermbg=None
				" highlight WinSeparator guibg=None ctermbg=None
				" highlight FloatNormal guibg=None ctermbg=None
				" highlight SignColumn guibg=None ctermbg=None
				" highlight LineNr guibg=None ctermbg=None
				" highlight GitGutterAdd guibg=None ctermbg=None
				" highlight GitGutterChangeDelete guibg=None ctermbg=None
				" highlight GitGutterChange guibg=None ctermbg=None
				" highlight GitGutterDelete guibg=None ctermbg=None
				" highlight FoldColumn guibg=None ctermbg=None
				" highlight FloatBorder guibg=None ctermbg=None
				" highlight NotifyBackground guibg=#000000 ctermbg=None
				" highlight Comment gui=italic cterm=italic 
				" highlight Identifier gui=italic cterm=italic 
				" highlight TSIdentifier gui=italic cterm=italic 
				" highlight TSProperty gui=italic cterm=italic 
				" highlight TSAttribute gui=italic cterm=italic 
				" highlight Type gui=italic cterm=italic 
				" highlight TSType gui=italic cterm=italic 
				" gray
				" highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
				" " blue
				" highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
				" highlight! CmpItemAbbr guibg=NONE
				" highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
				" " light blue
				" highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
				" highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
				" highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
				" " pink
				" highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
				" highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
				" " front
				" highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
				" highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
				" highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
	
				" highlight! TelescopePromptBorder 
	      ]])
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("MarkdownSpell", { clear = true }),
	pattern = "markdown",
	callback = function()
		vim.opt.spell = true
	end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
-- 	callback = function(data)
-- 		-- buffer is a real file on the disk
-- 		local real_file = vim.fn.filereadable(data.file) == 1
--
-- 		-- buffer is a [No Name]
-- 		local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--
-- 		if not real_file and not no_name then
-- 			return
-- 		end
--
-- 		-- open the tree, find the file but don't focus it
-- 		require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
-- 	end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.cmd("confirm quit")
		end
	end,
})

local group = vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = group,
	pattern = "?*",
	command = "mkview",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = group,
	pattern = "?*",
	command = "silent! loadview",
})

-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
-- 	group = vim.api.nvim_create_augroup("signature_help", { clear = true }),
-- 	pattern = "*",
-- 	callback = vim.lsp.buf.signature_help,
-- })
--
