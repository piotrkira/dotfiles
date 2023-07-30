return {
  { 'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<C-f>', '<cmd>Telescope find_files<cr>' },
      { '<C-g>', '<cmd>Telescope live_grep<cr>' },
      { '<leader>fw', '<cmd>Telescope grep_string<cr>' },
      { '<leader>fq', '<cmd>Telescope quickfix<cr>' },
    },
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension("frecency")
    end,
    dependencies = { "kkharji/sqlite.lua" },
    lazy = true,
  },
}
