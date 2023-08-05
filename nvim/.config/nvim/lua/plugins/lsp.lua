return {
  { 'neovim/nvim-lspconfig' },
  {
    'hrsh7th/nvim-cmp',
    opts = function()
      local cmp = require("cmp")
      local select_opts = { behavior = cmp.SelectBehavior.Select }
      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
          }),
          ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
          ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
          ['<C-k>'] = cmp.mapping.scroll_docs(-4),
          ['<C-j>'] = cmp.mapping.scroll_docs(4),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer', keyword_length = 5 },
        }),
        formatting = {
          format = require('lspkind').cmp_format({
            with_text = true,
            menu = ({
              buffer = "[buf]",
              path = "[path]",
              nvim_lsp = "[lsp]",
              nvim_lua = "[lua]",
              luasnip = "[snip]",
            })
          }),
        },
        preselect = false,
      }
    end,
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-cmdline' },
  { 'onsails/lspkind-nvim' },
  { 'hrsh7th/cmp-vsnip' },
  { 'L3MON4D3/LuaSnip' },
  {
    'ray-x/lsp_signature.nvim',
    opts = {
      hint_enable = false,
      handler_opts = {
        border = "single"
      }
    },
  },
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
  },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function()
      nls = require('null-ls')
      return {
        sources = {
          nls.builtins.diagnostics.mypy,
          nls.builtins.formatting.black,
          nls.builtins.formatting.isort,
          nls.builtins.diagnostics.ruff,
        }
      }
    end,
  },
}
