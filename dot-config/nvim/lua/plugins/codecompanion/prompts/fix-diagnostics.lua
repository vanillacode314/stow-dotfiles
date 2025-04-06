local M = {}

M.name = "Fix Diagnostics"
M.prompt = {
	strategy = "chat",
	description = "Fix LSP Diagnostics Issues",
	opts = {
		is_slash_cmd = true,
		short_name = "fixdiag",
	},
	prompts = {
		{
			role = "user",
			content = [[### **Tools**: @mcp, @editor

### **Resources**: #neovim://diagnostics/current, #buffer{watch}

### **Steps:**
1. Explain diagnostics issues concisely in an easy to understand way.
2. List the proposed fixes in codeblocks with a short summary. Only output the relevant part in the codeblocks, do not output the whole buffer.
2.1. If needed, ask the user or use a tool for more context or relevant questions before proposing a fix.
3. Ask the user for confirmation for applying the proposed changes.
3.1 If the user approves then apply the fix using the `editor` tool and then format using the mcp `format` tool.
3.2 If the user declines then just ask why and what they would like help with next.]],
		},
	},
}

return M
