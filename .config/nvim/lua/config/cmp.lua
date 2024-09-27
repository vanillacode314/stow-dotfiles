local cmp = require("cmp")
local lspkind = require("lspkind")
local types = require("cmp.types")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local has_words_before = function()
	---@diagnostic disable-next-line: deprecated
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local modified_priority = {
	[types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
	[types.lsp.CompletionItemKind.Snippet] = 0, -- top
	[types.lsp.CompletionItemKind.Keyword] = 0, -- top
	[types.lsp.CompletionItemKind.Text] = 100, -- bottom
}
---@param kind integer: kind of completion entry
local function modified_kind(kind)
	return modified_priority[kind] or kind
end

cmp.setup({
	completion = {
		winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
		autocomplete = {
			cmp.TriggerEvent.TextChanged,
			cmp.TriggerEvent.InsertEnter,
		},
		keyword_length = 0,
	},
	enabled = function()
		local filetype = vim.opt.filetype._value
		if filetype == "TelescopePrompt" then
			return false
		end
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	formatting = {
		expandable_indicator = true,
		fields = { "abbr", "kind", "menu" },
		format = lspkind.cmp_format({
			before = require("tailwindcss-colorizer-cmp").formatter,
			mode = "symbol_text",
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[lsp]",
				nvim_lua = "[lua]",
				snippets = "[snip]",
				cmp_tabnine = "[tn]",
				path = "[path]",
				rg = "[rg]",
			},
		}),
	},
	sorting = {
		priority_weight = 1,
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find("^_+")
				local _, entry2_under = entry2.completion_item.label:find("^_+")
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,
			function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
				local kind1 = modified_kind(entry1:get_kind())
				local kind2 = modified_kind(entry2:get_kind())
				if kind1 ~= kind2 then
					return kind1 - kind2 < 0
				end
			end,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	window = {
		-- completion = { border = require("utils").border_chars_outer_thin },
		documentation = { border = require("utils").border_chars_outer_thin },
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if vim.snippet.active({ direction = 1 }) then
				vim.schedule(function()
					vim.snippet.jump(1)
				end)
			elseif cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if vim.snippet.active({ direction = -1 }) then
				vim.schedule(function()
					vim.snippet.jump(-1)
				end)
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},
	sources = cmp.config.sources({
		{ name = "snippets", keyword_length = 2 },
		{ name = "nvim_lsp", trigger_characters = { "-", ">", "{" }, keyword_length = 2 },
		{ name = "fish" },
		{ name = "crates" },
	}, {
		-- { name = "nvim_lsp_signature_help" },
		{ name = "path" },
		-- {
		-- 			name = "buffer",
		-- 			keyword_length = 5,
		-- 			option = {
		-- 				get_bufnrs = function()
		-- 					local bufs = {}
		-- 					for _, win in ipairs(vim.api.nvim_list_wins()) do
		-- 						bufs[vim.api.nvim_win_get_buf(win)] = true
		-- 					end
		-- 					return vim.tbl_keys(bufs)
		-- 				end,
		-- 			},
		-- 		},
		{ name = "rg", keyword_length = 3 },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	---@diagnostic disable-next-line: missing-fields
	formatting = { fields = { "abbr" } },
	-- view = {
	-- 	entries = { name = "wildmenu", separator = " | " },
	-- },
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	---@diagnostic disable-next-line: missing-fields
	formatting = { fields = { "abbr" } },
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
