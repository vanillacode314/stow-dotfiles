local M = {}

M.name = "Smart Paste"
M.prompt = {
	strategy = "inline",
	description = "Paste code smartly",
	opts = {
		short_name = "paste",
		adapter = {
			name = "groq",
			model = "gemma2-9b-it",
		},
	},
	prompts = {
		{
			role = "user",
			content = [[You are a smart code paste agent within Neovim.

## **Task:** Intelligently integrate content from the user's clipboard into the current buffer.

## **Instructions:**

-   You may receive code in various programming languages or even natural language instructions.
-   If the clipboard content is in a different language than the current buffer, translate it to the appropriate language smartly.
-   If the clipboard content contains psudo code generate code accordingly.
-   If the clipboard content contains natural language instructions, interpret and follow them to modify the code in the current buffer.
-   **ONLY** generate the **new** lines of code required for seamless integration.
-   Ensure the inserted code is syntactically correct and logically consistent with the existing code.
-   Do **NOT** include surrounding code or line numbers.
-   Make sure all brackets and quotes are closed properly.

## **Output:**

-   Provide only the necessary lines of code for insertion.
-   If you can't generate code just return nothing.
-   Ensure the response is proper and well-formatted.
 ]],
		},
		{
			role = "user",
			content = function(context)
				local lines = require("codecompanion.helpers.actions").get_code(
					1,
					context.line_count,
					{ show_line_numbers = true }
				)
				local selection_info = ""
				local clipboard = vim.fn.getreg("+")

				if context.is_visual then
					selection_info =
						string.format("Currently selected lines: %d-%d", context.start_line, context.end_line)
				else
					selection_info = string.format(
						"Current cursor line: %d and Current cursor column is %d",
						context.cursor_pos[1],
						context.cursor_pos[2]
					)
				end

				return string.format(
					"I have the following code:\n\n```%s\n%s\n```\n\nClipboard content:\n\n```\n%s\n```\n\n%s",
					context.filetype,
					lines,
					clipboard,
					selection_info
				)
			end,
			opts = {
				contains_code = true,
			},
		},
	},
}

return M
