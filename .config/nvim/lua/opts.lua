vim.cmd([[colorscheme base16-tokyo-night-terminal-dark]])
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.autoread = true
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.scrolloff = 999
vim.opt.undolevels = 500
vim.opt.history = 500
vim.opt.ruler = true
vim.opt.linebreak = true
vim.opt.dir = vim.env.HOME .. "/.config/nvim/swap//"
vim.opt.backupdir = vim.env.HOME .. "/.config/nvim/backup//"
vim.opt.undofile = true
vim.opt.undodir = vim.env.HOME .. "/.config/nvim/undo//"
vim.opt.lazyredraw = false
vim.opt.virtualedit = "block,onemore"
vim.opt.joinspaces = false
vim.opt.breakindent = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.gdefault = true

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
-- vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"

-- Folding
vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99

-- Editing
vim.opt.backspace = "indent,eol,start"
vim.opt.updatetime = 500

-- Python
vim.g.python_host_skip_check = 1
vim.g.python3_host_prog = "python3"
vim.g.python_host_prog = "python2"

-- Session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
