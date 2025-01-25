require("config.diagnostics")
local M = {}
local border = "single"
M.handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}
M.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- M.capabilities = require("blink.cmp").get_lsp_capabilities()
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M.on_attach = function(client, bufnr)
	local client_opts = { remap = false, silent = true, buffer = bufnr }
	if not bufnr then
		bufnr = 0
	end
	if client.name == "eslint" then
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end
	vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
	vim.keymap.set("n", "<space>e", function()
		vim.diagnostic.open_float({ border = border })
	end, client_opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, client_opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, client_opts)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, client_opts)
	vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", client_opts)
	vim.keymap.set("n", "gd", function()
		local params = vim.lsp.util.make_position_params()
		return vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
			if result == nil or vim.tbl_isempty(result) then
				return
			end
			vim.lsp.util.preview_location(result[1], { border = border })
		end)
	end, client_opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.definition, client_opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, client_opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, client_opts)
	vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, client_opts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, client_opts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, client_opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, client_opts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, client_opts)
	-- vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", client_opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, client_opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, client_opts)
	vim.keymap.set("n", "<leader>fj", function()
		vim.lsp.buf.format({ async = true })
		vim.cmd("w")
	end, client_opts)
	-- require("lsp-inlayhints").on_attach(client, bufnr)
end

return M
