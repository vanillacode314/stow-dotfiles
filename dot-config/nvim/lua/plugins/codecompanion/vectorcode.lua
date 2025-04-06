local M = {}

function M:init(ctx)
	local has_vectorcode, vectorcode_integrations = pcall(require, "vectorcode.integrations")
	if has_vectorcode then
		ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
			strategies = {
				chat = {
					slash_commands = {
						codebase = vectorcode_integrations.codecompanion.chat.make_slash_command(),
					},
					tools = {
						vectorcode = {
							description = "Run VectorCode to retrieve the project context.",
							callback = vectorcode_integrations.codecompanion.chat.make_tool(),
						},
					},
				},
			},
		})
	end
end

return M
