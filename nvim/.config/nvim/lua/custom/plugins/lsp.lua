return {
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
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
          ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
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
      }
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'onsails/lspkind-nvim',
    }
  },
  {
    'L3MON4D3/LuaSnip',
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    'ray-x/lsp_signature.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      hint_enable = false,
      handler_opts = {
        border = "single"
      }
    },
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    config = true,
    build = ":MasonUpdate",
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require("mason-lspconfig").setup_handlers {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
        end,
      }
    end
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        htmldjango = { "djlint" },
        json = { "jq" },
        python = { "isort", "black" },
        go = { "gofmt" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "120" }
        }
      },
    },
    keys = {
      { "<leader>fc", function() require("conform").format({ lsp_fallback = true, async = true }) end },
      { "<leader>fc", function() require("conform").format({ lsp_fallback = true, async = true }) end, mode = "v" },
    }
  },
  {
    'mfussenegger/nvim-lint',
    event = { "BufReadPre", "BufNewFile", "InsertLeave" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        sh = { "shellcheck" },
      }
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        callback = function()
          --lint.try_lint()
        end,
      })
    end
  },
}
