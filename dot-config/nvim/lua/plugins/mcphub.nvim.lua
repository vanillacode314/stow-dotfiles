return {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = "MCPHub",
	build = "bun install -g mcp-hub@latest",
	config = function()
		vim.g.mcphub_auto_approve = true
		local root = vim.fs.root(0, ".git")
		if root then
			vim.fn.setenv("MCP_PROJECT_ROOT_PATH", root)
		end
		require("mcphub").setup()
		-- require("plugins.mcphub.format")
		-- require("plugins.mcphub.root_path")
	end,
}
