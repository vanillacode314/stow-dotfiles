local M = {}

M.name = "Vibe Code"
M.prompt = {
	opts = {},
	strategy = "chat",
	description = "Vibe Code Some Changes",
	prompts = {
		{
			role = "user",
			content = [[### **Steps:**

1. Decide if any tools provided are needed to perform the instructions.
1.1 If tools are needed, make the required tool calls before editing.
1.2 If no tools are required, start performing the edits right away.
2. Use @{neovim__edit_file} on #{buffer} to perform the instructions.
3. Format the buffer using the @{neovim__format} tool.

### **Instructions:**

Add comments]],
		},
	},
}

return M
