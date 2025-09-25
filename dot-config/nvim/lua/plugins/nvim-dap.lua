return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>qc",
				function()
					require("dap").continue()
				end,
				mode = { "n" },
				desc = "Continue",
			},
			{
				"<leader>qs",
				function()
					require("dap").step_over()
				end,
				mode = { "n" },
				desc = "Step Over",
			},
			{
				"<leader>qi",
				function()
					require("dap").step_into()
				end,
				mode = { "n" },
				desc = "Step Into",
			},
			{
				"<leader>qo",
				function()
					require("dap").step_out()
				end,
				mode = { "n" },
				desc = "Step Out",
			},
			{
				"<leader>qb",
				function()
					require("dap").toggle_breakpoint()
				end,
				mode = { "n" },
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>qr",
				function()
					require("dap").restart()
				end,
				mode = { "n" },
				desc = "Restart",
			},
		},
		config = function()
			local dap = require("dap")
			if not dap.adapters["pwa-chrome"] then
				dap.adapters["pwa-chrome"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "js-debug-adapter",
						args = {
							"${port}",
						},
					},
				}
			end

			for _, lang in ipairs({
				"typescript",
				"javascript",
				"typescriptreact",
				"javascriptreact",
			}) do
				dap.configurations[lang] = dap.configurations[lang] or {}
				-- table.insert(dap.configurations[lang], {
				-- 	type = "pwa-chrome",
				-- 	request = "launch",
				-- 	name = "Launch Chrome",
				-- 	url = "http://localhost:3000",
				-- 	sourceMaps = true,
				-- 	-- resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
				-- })
			end

			if not dap.adapters["python"] then
				dap.adapters.python = function(cb, config)
					if config.request == "attach" then
						local port = (config.connect or config).port
						local host = (config.connect or config).host or "127.0.0.1"
						cb({
							type = "server",
							port = assert(port, "`connect.port` is required for a python `attach` configuration"),
							host = host,
							options = {
								source_filetype = "python",
							},
						})
					else
						cb({
							type = "executable",
							command = "debugpy-adapter",
							options = {
								source_filetype = "python",
							},
						})
					end
				end
			end
			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					console = "integratedTerminal",
					cwd = "${workspaceFolder}",
					pythonPath = function()
						local cwd = vim.fn.getcwd()
						if os.getenv("VIRTUAL_ENV") then
							return os.getenv("VIRTUAL_ENV") .. "/bin/python"
						elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
							return cwd .. "/venv/bin/python"
						elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						else
							return "/usr/bin/python"
						end
					end,
				},
			}
		end,
	},
	{ "theHamsta/nvim-dap-virtual-text", config = true, event = "VeryLazy" },
	-- {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	event = { "VeryLazy" },
	-- 	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	-- 	config = function()
	-- 		require("dapui").setup()
	-- 		local dap, dapui = require("dap"), require("dapui")
	-- 		dap.listeners.before.attach.dapui_config = function()
	-- 			dapui.open()
	-- 		end
	-- 		dap.listeners.before.launch.dapui_config = function()
	-- 			dapui.open()
	-- 		end
	-- 		dap.listeners.before.event_terminated.dapui_config = function()
	-- 			dapui.close()
	-- 		end
	-- 		dap.listeners.before.event_exited.dapui_config = function()
	-- 			dapui.close()
	-- 		end
	-- 	end,
	-- },
	{
		"igorlfs/nvim-dap-view",
		---@module 'dap-view'
		---@type dapview.Config
		opts = {
			auto_toggle = true,
		},
	},
	-- { "LiadOz/nvim-dap-repl-highlights", config = true },
}
