require("config.diagnostics")
local M = {}
M.handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "none" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help),
}
M.capabilities = require("cmp_nvim_lsp").default_capabilities()

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
M.on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
	local client_opts = { remap = false, silent = true, buffer = bufnr }
	if not bufnr then
		bufnr = 0
	end
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<cr>", client_opts)
	vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", client_opts)
	vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", client_opts)
	vim.keymap.set("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", client_opts)
	vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", client_opts)
	vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", client_opts)
	vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", client_opts)
	vim.keymap.set("n", "K", function()
		local winid = require("ufo").peekFoldedLinesUnderCursor()
		if not winid then
			vim.cmd("Lspsaga hover_doc")
		end
	end, client_opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", client_opts)
	--[[ vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", client_opts) ]]
	vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", client_opts)
	vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", client_opts)
	vim.keymap.set(
		"n",
		"<leader>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		client_opts
	)
	vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", client_opts)
	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", client_opts)
	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", client_opts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", client_opts)
	vim.keymap.set("n", "<leader>fj", function()
		vim.lsp.buf.format({ async = true })
		vim.cmd("w")
	end, client_opts)
	require("lsp-inlayhints").on_attach(client, bufnr)
	-- print("LSP attached:", client.name)
end

return M
