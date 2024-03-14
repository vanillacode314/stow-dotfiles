local opts = { silent = true, noremap = true }

-- Global Clipboard using <leader>
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', opts)
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', opts)
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', opts)
vim.keymap.set({ "n", "v" }, "<leader>D", '"+D', opts)

-- Move through buffers
vim.keymap.set("n", "<Tab>", "<cmd>bn<cr>", opts)
vim.keymap.set("n", "<S-Tab>", "<cmd>bp<cr>", opts)

-- Better visual shifts
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("n", "0", "^", opts)
vim.keymap.set("n", "^", "0", opts)

-- Disable Arrow Keys
vim.keymap.set("n", "<up>", "<nop>", opts)
vim.keymap.set("n", "<down>", "<nop>", opts)
vim.keymap.set("n", "<left>", "<nop>", opts)
vim.keymap.set("n", "<right>", "<nop>", opts)

-- Tab Completion
-- vim.keymap.set({ "i", "s" }, "<c-k>", function()
-- 	local ls = require("luasnip")
-- 	if ls.expand_or_jumpable() then
-- 		ls.expand_or_jump()
-- 	end
-- end, opts)
-- vim.keymap.set({ "i", "s" }, "<c-j>", function()
-- 	local ls = require("luasnip")
-- 	if ls.jumpable(-1) then
-- 		ls.jump(-1)
-- 	end
-- end, opts)

-- Quickfix List
vim.keymap.set("n", "<leader>cn", function()
	vim.cmd("cnext")
end, opts)
vim.keymap.set("n", "<leader>cp", function()
	vim.cmd("cprev")
end, opts)

vim.keymap.set({ "n" }, "<leader>z", function()
	vim.cmd("ZenMode")
	vim.cmd([[highlight ZenBg guibg=0 ctermbg=0]])
end)
