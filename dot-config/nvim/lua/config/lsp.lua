require("config.diagnostics")

local M = {}

-- M.capabilities = require("cmp_nvim_lsp").default_capabilities()
M.capabilities = require("blink.cmp").get_lsp_capabilities()
-- M.capabilites = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

M.on_attach = function(client, bufnr)
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
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, {
			bufnr = bufnr,
		})
	end

	-- Keymaps
	local client_opts = { remap = false, silent = true, buffer = bufnr }
	-- vim.keymap.set(
	-- 	"n",
	-- 	"<space>q",
	-- 	vim.diagnostic.setloclist,
	-- 	vim.tbl_extend("force", client_opts, { desc = "Add Diagnostic to loclist" })
	-- )
	vim.keymap.set(
		"n",
		"gi",
		vim.lsp.buf.implementation,
		vim.tbl_extend("force", client_opts, { desc = "List Implementations" })
	)
	vim.keymap.set(
		"n",
		"<C-K>",
		vim.lsp.buf.signature_help,
		vim.tbl_extend("force", client_opts, { desc = "Signature Help" })
	)
	vim.keymap.set(
		"n",
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		vim.tbl_extend("force", client_opts, { desc = "Add Workspace Folder" })
	)
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		vim.tbl_extend("force", client_opts, { desc = "Remove Workspace Folder" })
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, vim.tbl_extend("force", client_opts, { desc = "Print Workspace Folders" }))
	vim.keymap.set(
		"n",
		"<leader>D",
		vim.lsp.buf.type_definition,
		vim.tbl_extend("force", client_opts, { desc = "Jump To Type Definition" })
	)
	vim.keymap.set("n", "<leader>ca", function()
		require("fastaction").code_action()
	end, vim.tbl_extend("force", client_opts, { desc = "Code Actions" }))
	vim.keymap.set(
		"n",
		"<leader>rn",
		vim.lsp.buf.rename,
		vim.tbl_extend("force", client_opts, { desc = "Rename Symbol" })
	)
	vim.keymap.set("n", "<leader>fj", function()
		-- vim.lsp.buf.format({ async = true })
		require("conform").format({ async = true })
		vim.cmd("w")
	end, vim.tbl_extend("force", client_opts, { desc = "Format Buffer" }))

	-- Setup plugins
	require("better-diagnostic-virtual-text.api").setup_buf(bufnr, {})
end

return M
