local mcphub = require("mcphub")

mcphub.add_resource("neovim", {
	name = "root_path",
	description = [[Get the root path of the currently opened project]],
	uri = "neovim://root_path",
	mimeType = "text/plain",
	handler = function(req, res)
		res:text(vim.fn.getcwd()):send()
	end,
})
