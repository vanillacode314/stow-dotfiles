local kind_icons = {
	Text = "󰉿",
	Method = "󰊕",
	Function = "󰊕",
	Constructor = "󰒓",

	Field = "󰜢",
	Variable = "󰆦",
	Property = "󰖷",

	Class = "󱡠",
	Interface = "󱡠",
	Struct = "󱡠",
	Module = "󰅩",

	Unit = "󰪚",
	Value = "󰦨",
	Enum = "󰦨",
	EnumMember = "󰦨",

	Keyword = "󰻾",
	Constant = "󰏿",

	Snippet = "󱄽",
	Color = "󰏘",
	File = "󰈔",
	Reference = "󰬲",
	Folder = "󰉋",
	Event = "󱐋",
	Operator = "󰪚",
	TypeParameter = "󰬛",

	claude = "󰋦",
	openai = "󱢆",
	codestral = "󱎥",
	gemini = "",
	Groq = "",
	Openrouter = "󱂇",
	Ollama = "󰳆",
	["Llama.cpp"] = "󰳆",
	Deepseek = "",
}
local source_icons = {
	minuet = "󱗻",
	orgmode = "",
	otter = "󰼁",
	nvim_lsp = "",
	lsp = "",
	buffer = "",
	luasnip = "",
	snippets = "",
	path = "",
	git = "",
	tags = "",
	cmdline = "󰘳",
	latex_symbols = "",
	cmp_nvim_r = "󰟔",
	codeium = "󰩂",
	-- FALLBACK
	fallback = "󰜚",
}

return {
	"saghen/blink.cmp",
	event = "VeryLazy",
	dependencies = {
		-- "Kaiser-Yang/blink-cmp-avante",
		"rafamadriz/friendly-snippets",
	},

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = "default" },
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
			kind_icons = kind_icons,
		},
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				codecompanion = { "codecompanion" },
				-- Avante = { "avante" },
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				-- avante = {
				-- 	module = "blink-cmp-avante",
				-- 	name = "Avante",
				-- 	opts = {
				-- 		-- options for blink-cmp-avante
				-- 	},
				-- },
				-- lsp = {
				-- 	min_keyword_length = 0,
				-- 	score_offset = 4,
				-- },
				-- snippets = {
				-- 	min_keyword_length = 0,
				-- 	score_offset = 3,
				-- },
				-- path = {
				-- 	min_keyword_length = 0,
				-- 	score_offset = 2,
				-- },
				-- buffer = {
				-- 	min_keyword_length = 0,
				-- 	score_offset = 1,
				-- },
			},
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
		completion = {
			-- menu = {
			-- 	draw = {
			-- 		columns = {
			-- 			{ "label", "label_description", gap = 1 },
			-- 			{ "kind_icon", gap = 1, "kind" },
			-- 		},
			-- 	},
			-- },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
		},
		snippets = { preset = "default" },
		signature = { enabled = true },
	},
	config = function(ctx)
		local has_minuet, minuet = pcall(require, "minuet")
		if has_minuet then
			ctx.opts = vim.tbl_deep_extend("force", ctx.opts, {
				keymap = {
					-- Manually invoke minuet completion.
					["<A-y>"] = minuet.make_blink_map(),
				},
				sources = {
					-- For manual completion only, remove 'minuet' from default
					providers = {
						minuet = {
							name = "minuet",
							module = "minuet.blink",
							score_offset = 8,
						},
					},
				},
				-- Recommended to avoid unnecessary request
				completion = { trigger = { prefetch_on_insert = false } },
			})
			table.insert(ctx.opts.sources.default, "minuet")
		end

		require("blink.cmp").setup(ctx.opts)
	end,
	opts_extend = { "sources.default" },
}
