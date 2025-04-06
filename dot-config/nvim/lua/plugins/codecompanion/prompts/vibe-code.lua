local M = {}

function M:init(ctx)
	ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
		prompt_library = {
			["Vibe Code"] = {
				strategy = "chat",
				description = "Vibe Code Some Changes",
				prompts = {
					{
						role = "user",
						content = [[
Use @editor on #buffer{watch} to perform the following tasks:
- 
 ]],
					},
				},
			},
		},
	})
end

return M
