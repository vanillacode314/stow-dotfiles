--[[ vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave", "InsertEnter" }, { ]]
--[[ 	pattern = "*", ]]
--[[ 	group = vim.api.nvim_create_augroup("LspSagaHold", { clear = true }), ]]
--[[ 	command = "Lspsaga show_cursor_diagnostics", ]]
--[[ }) ]]
vim.diagnostic.config({
	--[[ virtual_text = { ]]
	--[[ 	prefix = "", ]]
	--[[ }, ]]
	-- virtual_text = {
	-- 	enabled = false,
	-- 	severity = vim.diagnostic.severity.ERROR,
	-- },
	-- virtual_lines = { current_line = true },
	virtual_text = false,
	signs = true,
	underline = true,
	severity_sort = false,
})

-- local signs = require("utils").diagnostic_signs
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end
