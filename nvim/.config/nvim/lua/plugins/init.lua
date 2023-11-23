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
      return {
        { ',,', function() require('harpoon.mark').add_file() end },
        { ',w', function() require("harpoon.ui").toggle_quick_menu() end },
        { ',a', function() require("harpoon.ui").nav_file(1) end },
        { ',s', function() require("harpoon.ui").nav_file(2) end },
        { ',d', function() require("harpoon.ui").nav_file(3) end },
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
      progress = {
        display = {
          done_icon = ""
        }
      },
      notification = {
        window = {
          winblend = 0,
        }
      }
    }
  },

  {
    'ThePrimeagen/refactoring.nvim',
    keys = function()
      return {
        { '<leader>re', function() require("refactoring").refactor('Extract Function') end },
        { '<leader>rf', function() require("refactoring").refactor('Extract Function To File') end },
        { '<leader>rv', function() require("refactoring").refactor('Extract Variable') end },
        { '<leader>ri', function() require("refactoring").refactor('Inline Variable') end },
      }
    end,
  },
}
