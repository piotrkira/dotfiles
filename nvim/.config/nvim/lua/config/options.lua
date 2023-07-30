vim.g.mapleader = ' '

local opt = vim.opt

opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.clipboard = 'unnamedplus'
opt.updatetime = 50
opt.timeoutlen = 600
opt.cmdheight = 0
opt.showmode = false
opt.hidden = true
opt.wrap = false

opt.backup = false
opt.swapfile = false

opt.writebackup = false
opt.smartindent = true

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true

opt.showtabline = 2
opt.number = true
opt.relativenumber = true

opt.signcolumn = 'yes'

vim.cmd('set omnifunc=syntaxcomplete#Complete')
opt.encoding = 'UTF-8'
opt.smartcase = true
opt.cursorline = true
opt.sidescrolloff = 5
opt.scrolloff= 6
opt.autoindent = true
opt.ruler = true
opt.incsearch = true
vim.cmd('set formatoptions-=cro')
opt.colorcolumn = "80"
opt.shortmess:append("c")
