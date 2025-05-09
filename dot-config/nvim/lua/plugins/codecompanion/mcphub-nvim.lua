local M = {}

function M:init(ctx)
	local has_mcphub, _ = pcall(require, "mcphub")
	if has_mcphub then
		ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						show_result_in_chat = true, -- Show mcp tool results in chat
						make_vars = true, -- Convert resources to #variables
						make_slash_commands = true, -- Add prompts as /slash commands
					},
				},
			},
		})
	end
end

return M
