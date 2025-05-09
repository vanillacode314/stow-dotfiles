local M = {}

function M:init(ctx)
	local has_vectorcode, vectorcode_integrations = pcall(require, "vectorcode.integrations")
	if has_vectorcode then
		ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
			extensions = {
				vectorcode = {
					opts = {
						add_tool = true,
					},
				},
			},
		})
	end
end

return M
