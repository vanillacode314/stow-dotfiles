local mcphub = require("mcphub")

mcphub.add_tool("neovim", {
	name = "format",
	description = [[Formats the provided neovim buffer. If you do not have access to a neovim buffer number. Ask the user for clarification before calling this tool]],
	inputSchema = {
		type = "object",
		properties = {
			bufnr = {
				type = "number",
				description = "The buffer number to format",
			},
		},
	},
	handler = function(req, res)
		local bufnr = req.params.bufnr
		if not bufnr then
			return res:error("bufnr not provided")
		end
		if not type(bufnr) == "number" then
			return res:error("bufnr should be a number")
		end
		require("conform").format({ async = true, bufnr = bufnr })
		res:text("Formatted buffer #" .. bufnr .. " Successfully!"):send()
	end,
})
