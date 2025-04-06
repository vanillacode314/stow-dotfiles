local M = {}

function M:init(ctx)
	local has_mcphub, _ = pcall(require, "mcphub")
	if has_mcphub then
		ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
			strategies = {
				chat = {
					tools = {
						["mcp"] = {
							-- Prevent mcphub from loading before needed
							callback = function()
								return require("mcphub.extensions.codecompanion")
							end,
							description = "Call tools and resources from the MCP Servers",
						},
					},
				},
			},
		})
	end
end

return M
