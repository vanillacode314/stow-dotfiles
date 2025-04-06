return {
	"milanglacier/minuet-ai.nvim",
	enabled = true,
	config = function()
		require("minuet").setup({
			provider = "codestral",
			-- request_timeout = 2.5,
			-- throttle = 1500, -- Increase to reduce costs and avoid rate limits
			-- debounce = 600, -- Increase to reduce costs and avoid rate limits
			-- n_completions = 1,
			-- context_window = 512,
			provider_options = {
				openai_compatible = {
					api_key = "OPENROUTER_API_KEY",
					end_point = "https://openrouter.ai/api/v1/chat/completions",
					model = "agentica-org/deepcoder-14b-preview:free",
					name = "Openrouter",
					optional = {
						max_tokens = 128,
						top_p = 0.9,
						provider = {
							-- Prioritize throughput for faster completion
							sort = "throughput",
						},
					},
				},
				-- openai_compatible = {
				-- 	api_key = "GROQ_API_KEY",
				-- 	name = "Groq",
				-- 	end_point = "https://api.groq.com/openai/v1/chat/completions",
				-- 	model = "llama-3.1-8b-instant",
				-- 	optional = {
				-- 		max_tokens = 256,
				-- 		top_p = 0.9,
				-- 	},
				-- },
				gemini = {
					model = "gemini-2.0-flash",
					stream = true,
					api_key = "GEMINI_API_KEY",
					optional = {
						generationConfig = {
							maxOutputTokens = 256,
						},
						safetySettings = {
							{
								-- HARM_CATEGORY_HATE_SPEECH,
								-- HARM_CATEGORY_HARASSMENT
								-- HARM_CATEGORY_SEXUALLY_EXPLICIT
								category = "HARM_CATEGORY_DANGEROUS_CONTENT",
								-- BLOCK_NONE
								threshold = "BLOCK_ONLY_HIGH",
							},
						},
					},
				},
			},
		})
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
}
