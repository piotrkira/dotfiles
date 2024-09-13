return {
  { 'kyazdani42/nvim-web-devicons', lazy=true },
  {
    'windwp/nvim-autopairs',
    opts = {
      check_ts = true,
    }
  },
  {
    'ThePrimeagen/harpoon',
    branch = "harpoon2",
    lazy = false,
    keys = function()
      return {
        { ',,', function() require("harpoon"):list():add() end },
        { ',w', function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },
        { ',a', function() require("harpoon"):list():select(1) end },
        { ',s', function() require("harpoon"):list():select(2) end },
        { ',d', function() require("harpoon"):list():select(3) end },
        { ',f', function() require("harpoon"):list():select(4) end },
        { ',g', function() require("harpoon"):list():select(5) end },
      }
    end,
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      local function get_harpoon_statusline()
        local marks_length = harpoon:list():length()
        if marks_length == 0 then
          return ""
        end
        local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
        local contents = {}
        for index = 1, marks_length do
          local harpoon_file_path = harpoon:list():get(index).value
          local file_name = vim.fn.fnamemodify(harpoon_file_path, ":t")

          if current_file_path == harpoon_file_path then
            contents[index] = string.format("%%#Search# %s. %%#Search#%s %%#Statusline#", index, file_name)
          else
            contents[index] = string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, file_name)
          end
        end

        return table.concat(contents)
      end

      vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "User" }, {
        callback = function(_)
          local harpoon_files = get_harpoon_statusline()
          if harpoon_files ~= "" then
            vim.o.tabline = harpoon_files
          end
        end
      })
    end
  },
  {
    'simrat39/symbols-outline.nvim',
    keys = {
      { '<leader>so', '<cmd>:SymbolsOutline<cr>' }
    },
    config = function()
      require("symbols-outline").setup()
    end,
  },

  {
    'kylechui/nvim-surround',
    config = function()
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
  {
    'ThePrimeagen/vim-apm',
    keys = function()
      return {
        { '<leader>apm', function() require("vim-apm"):toggle_monitor() end },
      }
    end
  },
  {
    'github/copilot.vim'
  }
}
