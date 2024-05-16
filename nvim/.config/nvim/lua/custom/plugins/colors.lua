return {
  { 'ntpeters/vim-better-whitespace' },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    'sainnhe/everforest',
    priority = 1000,
    init = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_transparent_background = 1
    end,
    config = function()
      vim.cmd.colorscheme("everforest")
    end,
  },
  { 'catppuccin/nvim',               lazy = true },
  { 'folke/tokyonight.nvim',         lazy = true },
  { 'rebelot/kanagawa.nvim',         lazy = true },
  { 'EdenEast/nightfox.nvim',        lazy = true },
}
