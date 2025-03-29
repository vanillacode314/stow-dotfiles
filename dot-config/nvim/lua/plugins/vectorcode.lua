return {
	"Davidyz/VectorCode",
	enabled = false,
	version = "*", -- optional, depending on whether you're on nightly or release
	build = "pipx upgrade vectorcode", -- optional but recommended if you set `version = "*"`
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("vectorcode").setup({
			async_opts = {
				run_on_register = false,
			},
			async_backend = "lsp",
			on_setup = {
				lsp = true,
				update = true,
			},
		})
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function()
				local cacher = require("vectorcode.config").get_cacher_backend()
				local bufnr = vim.api.nvim_get_current_buf()
				cacher.async_check("config", function()
					cacher.register_buffer(bufnr, {
						n_query = 10,
						notify = false,
					})
				end, nil)
			end,
			desc = "Register buffer for VectorCode",
		})
	end,
}
