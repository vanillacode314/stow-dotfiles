local RAG_Context_Window_Size = 4000

return {
	"milanglacier/minuet-ai.nvim",
	enabled = true,
	config = function()
		require("minuet").setup({
			provider = "codestral",
			-- request_timeout = 5,
			-- throttle = 1500, -- Increase to reduce costs and avoid rate limits
			-- debounce = 600, -- Increase to reduce costs and avoid rate limits
			n_completions = 1,
			-- context_window = 1024,
			provider_options = {
				openai_fim_compatible = {
					api_key = "TERM",
					end_point = "http://localhost:9292/v1/completions",
					model = "qwen2.5.1-coder-1.5b",
					name = "Llama.cpp",
					optional = {
						max_tokens = 128,
						top_p = 0.9,
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
