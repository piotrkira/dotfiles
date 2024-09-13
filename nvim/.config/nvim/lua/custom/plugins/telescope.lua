return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
      { '<C-f>',      '<cmd>Telescope find_files<cr>' },
      { '<C-g>',      '<cmd>Telescope live_grep<cr>' },
      { '<leader>fw', '<cmd>Telescope grep_string<cr>' },
      { '<leader>fq', '<cmd>Telescope quickfix<cr>' },
    },
    config = function ()
      local telescope = require('telescope')
      telescope.load_extension("fzf")
    end,
  },
}
