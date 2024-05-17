local set = vim.keymap.set

set('n', '<Space>', '<NOP>')

set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

set('n', 'n', 'nzz')
set('n', 'N', 'Nzz')

set('n', '<leader>gd', vim.lsp.buf.definition)
set('n', '<leader>gD', vim.lsp.buf.declaration)
set('n', '<leader>gr', vim.lsp.buf.references)
set('n', '<leader>gi', vim.lsp.buf.implementation)
set('n', '<leader>rn', vim.lsp.buf.rename)
set('n', '<leader>ca', vim.lsp.buf.code_action)
set('n', '<leader>sh', vim.lsp.buf.signature_help)
set('n', '<leader>e', vim.diagnostic.open_float)
set('n', '<C-p>', vim.diagnostic.goto_prev)
set('n', '<C-n>', vim.diagnostic.goto_next)
set('n', 'K', vim.lsp.buf.hover)

set('n', '<C-J>', '<cmd>:cnext<cr>')
set('n', '<C-K>', '<cmd>:cprev<cr>')
set('v', '<', '<gv')
set('v', '>', '>gv')
set('n', 'Y', 'y$')
