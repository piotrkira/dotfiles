return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      return {
        require("nvim-treesitter.configs").setup({
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
          rainbow = {
            enable = true,
            extended_mode = true,
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
              },
              include_surrounding_whitespace = false,
            },
            swap = {
              enable = true,
              swap_next = {
                ["<leader>a"] = "@parameter.inner",
              },
              swap_previous = {
                ["<leader>A"] = "@parameter.inner",
              },
            },
          }
        })
      }
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'romgrk/nvim-treesitter-context' },
}
