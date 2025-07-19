return {
	"Davidyz/VectorCode",
	enabled = false,
	version = "*", -- optional, depending on whether you're on nightly or release
	build = "uv tool upgrade vectorcode", -- optional but recommended if you set `version = "*"`
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("vectorcode").setup({
			async_backend = "lsp",
			n_query = 10,
			notify = false,
		})
		-- vim.api.nvim_create_autocmd("LspAttach", {
		-- 	callback = function(ev)
		-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		-- 		if client == nil then
		-- 			return
		-- 		end
		-- 		if client.name == "vectorcode-server" then
		-- 			return
		-- 		end
		-- 		local cacher = require("vectorcode.config").get_cacher_backend()
		-- 		local utils = require("vectorcode.utils")
		-- 		cacher.async_check("config", function()
		-- 			cacher.register_buffer(ev.buf, {
		-- 				n_query = 10,
		-- 				notify = false,
		-- 				query_cb = utils.make_lsp_document_symbol_cb(),
		-- 			})
		-- 		end, nil)
		-- 	end,
		-- 	desc = "Register buffer for VectorCode",
		-- })
	end,
}
