vim.g.mapleader = " "
vim.g.loaded_python3_provider = 0

local o = vim.o
o.inccommand = "split"
o.pumheight = 10
o.termguicolors = true
o.splitright = true
o.splitbelow = true
o.clipboard = "unnamedplus"
o.updatetime = 50
o.timeoutlen = 600
o.showmode = false
o.wrap = false

o.swapfile = false

o.writebackup = false
o.smartindent = true

o.shiftwidth = 2
o.tabstop = 2
o.expandtab = true

o.showtabline = 2

o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.background = "dark"

o.smartcase = true
o.ignorecase = true
o.cursorline = true
o.sidescrolloff = 5
o.scrolloff = 6
o.formatoptions = o.formatoptions:gsub("c", "")
o.colorcolumn = "80"
o.shortmess = o.shortmess .. "c"
