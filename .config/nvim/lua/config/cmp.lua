local has_words_before = function()
	---@diagnostic disable-next-line: deprecated
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
		format = lspkind.cmp_format({
			before = require("tailwindcss-colorizer-cmp").formatter,
			mode = "symbol_text",
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[lsp]",
				nvim_lua = "[lua]",
				luasnip = "[snip]",
				cmp_tabnine = "[tn]",
				path = "[path]",
				rg = "[rg]",
			},
		}),
	},
	sorting = {
		-- priority_weight = 2,
		comparators = {
			-- require("cmp_tabnine.compare"),
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			require("cmp-under-comparator").under,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		-- completion = { border = require("utils").border_chars_outer_thin },
		documentation = { border = require("utils").border_chars_outer_thin },
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if ls.jumpable(1) then
				ls.jump(1)
			elseif cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if ls.jumpable(-1) then
				ls.jump(-1)
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
		{ name = "nvim_lsp", trigger_characters = { "-" } },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "fish" },
		{ name = "cmp-tw2css" },
		{ name = "crates" },
	}, {
		-- { name = "nvim_lsp_signature_help" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 3 },
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
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	view = {
		entries = { name = "wildmenu", separator = " | " },
	},
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
