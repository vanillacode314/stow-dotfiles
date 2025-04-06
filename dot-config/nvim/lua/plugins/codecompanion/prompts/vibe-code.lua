local M = {}

M.name = "Vibe Code"
M.prompt = {
	strategy = "chat",
	description = "Vibe Code Some Changes",
	prompts = {
		{
			role = "user",
			content = [[### **Instructions:**

Your instructions

### **Steps:**

1. Decide if tools provided by @mcp are needed to perform the instructions.
1.1 If tools are needed, make the required tool calls before editing.
1.2 If no tools are required, start performing the edits right away.
2. Use @editor on #buffer{watch} to perform the instructions.
3. Format the buffer using the mcp `format` tool.]],
		},
	},
}

return M
