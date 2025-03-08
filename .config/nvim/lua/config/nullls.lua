local null_ls = require("null-ls")

require("null-ls").setup({
	sources = {
		-- null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.code_actions.gitsigns.with({
			-- config = {
			-- 	filter_actions = function(title)
			-- 		return title:lower():match("blame") == nil -- filter out blame actions
			-- 	end,
			-- },
		}),
		-- null_ls.builtins.code_actions.ltrs,
		-- null_ls.builtins.diagnostics.ltrs,
		null_ls.builtins.hover.dictionary,
		null_ls.builtins.hover.printenv,
		null_ls.builtins.code_actions.proselint,
		null_ls.builtins.diagnostics.proselint,
		-- null_ls.builtins.diagnostics.pycodestyle,
		-- null_ls.builtins.code_actions.refactoring,
		-- null_ls.builtins.diagnostics.ruff,
		-- null_ls.builtins.formatting.ruff,
		-- null_ls.builtins.code_actions.ruff,
		-- null_ls.builtins.completion.spell,
		-- require("typescript.extensions.null-ls.code-actions"),
	},
	-- on_attach = require("config.lsp").on_attach,
})
