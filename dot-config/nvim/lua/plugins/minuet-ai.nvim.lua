local RAG_Context_Window_Size = 4000

return {
	"milanglacier/minuet-ai.nvim",
	enabled = true,
	config = function()
		require("minuet").setup({
			provider = "codestral",
			request_timeout = 10,
			-- throttle = 1500, -- Increase to reduce costs and avoid rate limits
			-- debounce = 600, -- Increase to reduce costs and avoid rate limits
			n_completions = 1,
			add_single_line_entry = false,
			-- context_window = 512,
			provider_options = {
				openai_compatible = {
					api_key = "OPENROUTER_API_KEY",
					end_point = "https://openrouter.ai/api/v1/chat/completions",
					model = "openai/gpt-oss-120b",
					name = "Openrouter",
					optional = {
						-- max_completion_tokens = 256,
						reasoning_effort = "none",
						reasoning = { effort = "none" },
						top_p = 0.9,
						provider = { sort = "throughput" },
					},
				},
				openai_fim_compatible = {
					api_key = "TERM",
					end_point = "https://llama-swap.homelab.lan/v1/completions",
					model = "qwen-2.5-coder-3b",
					name = "llama-swap",
					optional = {
						-- max_tokens = 256,
						-- chat_template_kwargs = {
						-- 	enable_thinking = false,
						-- },
					},
					template = {
						prompt = function(context_before_cursor, context_after_cursor, _)
							local prompt_message = ""

							local has_vc, vectorcode_config = pcall(require, "vectorcode.config")
							local vectorcode_cacher = nil
							if has_vc then
								vectorcode_cacher = vectorcode_config.get_cacher_backend()
								for _, file in ipairs(vectorcode_cacher.query_from_cache(0)) do
									prompt_message = prompt_message
										.. "<|file_sep|>"
										.. file.path
										.. "\n"
										.. file.document
								end
								prompt_message = vim.fn.strcharpart(prompt_message, 0, RAG_Context_Window_Size)
							end
							return prompt_message
								.. "<|fim_prefix|>"
								.. context_before_cursor
								.. "<|fim_suffix|>"
								.. context_after_cursor
								.. "<|fim_middle|>"
						end,
						suffix = false,
					},
				},
			},
		})
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}
