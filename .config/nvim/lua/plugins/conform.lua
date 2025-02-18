---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
	local conform = require("conform")
	for i = 1, select("#", ...) do
		local formatter = select(i, ...)
		if conform.get_formatter_info(formatter, bufnr).available then
			return formatter
		end
	end
	return select(1, ...)
end

return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	config = function()
		local prettier_chain = { "prettierd", "prettier", stop_after_first = true }
		local js_chain = function(bufnr)
			return { first(bufnr, "prettierd", "prettier"), "eslint_d" }
		end
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				yaml = { "yamlfmt" },
				python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
				typescript = js_chain,
				javascript = js_chain,
				javascriptreact = js_chain,
				typescriptreact = js_chain,
				svelte = js_chain,
				vue = js_chain,
				css = prettier_chain,
				scss = prettier_chain,
				jsonc = prettier_chain,
				proto = { "buf" },
				sql = { "sql_formatter" },
				json = { "jq" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				fish = { "fish_indent" },
				rust = { "rustfmt" },
				nix = { "nixfmt" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
				-- ["*"] = { "injected" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
		require("conform").formatters.sql_formatter = {
			prepend_args = { "-c", vim.fn.expand("~/.config/sql-formatter.json") },
		}
	end,
}
