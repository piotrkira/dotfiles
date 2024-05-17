return {
  {
    'nvim-neotest/neotest',
    opts = function()
      return {
        adapters = {
          require('neotest-python')({}),
          require('neotest-go'),
        }
      }
    end,
    keys = function()
      return {
        { '<leader>rt',  function() require("neotest").run.run() end },
        { '<leader>rat', function() require("neotest").run.run(vim.fn.expand("%")) end },
        { '<leader>dt',  function() require("neotest").run.run({ strategy = "dap" }) end },
      }
    end,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-go',
    }
  },
  {
    'mfussenegger/nvim-dap',
    keys = function()
      return {
        { '<leader>b',  function() require("dap").toggle_breakpoint() end },
        { '<leader>cb', function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
        { '<leader>lp', function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
        { '<leader>rd', function() require("dap").continue() end },
        { '<Down>',     function() require("dap").step_over() end },
        { '<Right>',    function() require("dap").step_into() end },
        { '<Up>',       function() require("dap").step_back() end },
        { '<Left>',     function() require("dap").step_out() end },
        { '<leader>dr', function() require("dap").repl.open() end },
        { '<leader>rc', function() require("dap").run_to_cursor() end },
        { '<leader>gt', function() require("dap").goto_() end },
        { '<leader>lb', function() require("dap").list_breakpoints() end },
        { '<leader>rl', function() require("dap").run_last() end },
      }
    end,
    init = function()
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Debug', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'Debug', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'Debug', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'Debug', linehl = '', numhl = '' })
    end,
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    }
  },
  {
    'rcarriga/nvim-dap-ui',
    opts = {
      layouts = { {
        elements = { {
          id = "scopes",
          size = 0.25
        }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
          size = 0.25
        }, {
          id = "watches",
          size = 0.20
        } },
        position = "right",
        size = 40
      }, {
        elements = { {
          id = "repl",
          size = 0.5
        }, {
          id = "console",
          size = 0.5
        } },
        position = "bottom",
        size = 10
      } },
    },
    keys = function()
      return {
        { '<leader>dw', function() require("dapui").toggle() end },
        { '<leader>v',  function() require("dapui").eval() end },
      }
    end,
    config = function(_, opts)
      require('dapui').setup(opts)
      local dap, dapui = require('dap'), require('dapui')
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require("dap-python").setup()
    end,
    lazy = true,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
    lazy = true,
  },
}
