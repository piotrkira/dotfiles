return {
  {
    'lewis6991/gitsigns.nvim',
    keys = {
      { '<leader>pd', '<cmd>:Gitsigns preview_hunk_inline<cr>' },
      { '<leader>rh', '<cmd>:Gitsigns reset_hunk<cr>' },
      { '<leader>nh', '<cmd>:Gitsigns prev_hunk<cr>' },
      { '<leader>nh', '<cmd>:Gitsigns next_hunk<cr>' },
    },
    init = function()
      require("gitsigns").setup()
    end,
  },
  {
    'f-person/git-blame.nvim',
    init = function()
      vim.g.gitblame_enabled = false
      vim.g.gitblame_message_template = '<summary> • <date> • <author>'
      vim.g.gitblame_date_format = '%r'
    end,
    keys = {
      { '<leader>gb',  '<cmd>:GitBlameToggle<cr>' },
      { '<leader>ogb', '<cmd>:GitBlameOpenCommitURL<cr>' },
    }
  },
  {
    'ruifm/gitlinker.nvim',
    keys = function()
      local linker = require("gitlinker")
      return {
        { '<leader>ogl',
                           function() linker.get_buf_range_url("n",
              { action_callback = require "gitlinker.actions".open_in_browser }) end },
        { '<leader>ogl',
                           function() linker.get_buf_range_url("v",
              { action_callback = require "gitlinker.actions".open_in_browser }) end,                                                    mode =
        "v" },
        { '<leader>cgl',
                           function() linker.get_buf_range_url("n",
              { action_callback = require "gitlinker.actions".copy_to_clipboard }) end },
        { '<leader>cgl',
                           function() linker.get_buf_range_url("v",
              { action_callback = require "gitlinker.actions".copy_to_clipboard }) end,                                                  mode =
        "v" },
      }
    end,
  },
  { 'sindrets/diffview.nvim' },
}
