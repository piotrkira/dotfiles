return {
  { 'kyazdani42/nvim-web-devicons' },
  {
    'windwp/nvim-autopairs',
    opts = {
      check_ts = true,
    }
  },
  {
    'ThePrimeagen/harpoon',
    keys = function()
      local ui = require("harpoon.ui")
      return {
        { ',,', function() require('harpoon.mark').add_file() end },
        { ',w', function() ui.toggle_quick_menu() end },
        { ',a', function() ui.nav_file(1) end },
        { ',s', function() ui.nav_file(2) end },
        { ',d', function() ui.nav_file(3) end },
      }
    end,
  },
  {
    'ggandor/leap.nvim',
    config = function()
      local leap = require("leap")
      leap.add_default_mappings()
      leap.opts.safe_labels = {}
    end,
  },

  {
    'simrat39/symbols-outline.nvim',
    keys = {
      { '<leader>so', '<cmd>:SymbolsOutline<cr>' }
    },
    config = function ()
      require("symbols-outline").setup()
    end,
  },

  { 'b3nj5m1n/kommentary' },

  { 'kylechui/nvim-surround',
    config = function ()
      require("nvim-surround").setup({})
    end
  },

  {
    'j-hui/fidget.nvim',
    opts = {
      text = {
        spinner = "dots",
        done = ""
      },
      window = {
        blend = 0,
      }
    }
  },

  {
    'ThePrimeagen/refactoring.nvim',
    keys = function()
      local ref = require("refactoring")
      return {
        { '<leader>re', function() ref.refactor('Extract Function') end },
        { '<leader>rf', function() ref.refactor('Extract Function To File') end },
        { '<leader>rv', function() ref.refactor('Extract Variable') end },
        { '<leader>ri', function() ref.refactor('Inline Variable') end },
      }
    end,
  },
}
