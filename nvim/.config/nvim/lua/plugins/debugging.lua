return {
  {
    'nvim-neotest/neotest',
    opts = function()
      return {
        adapters = {
          require('neotest-python')({})
        }
      }
    end,
    keys = function()
      local neotest = require("neotest")
      return {
        { '<leader>rt',  function() neotest.run.run() end },
        { '<leader>rat', function() neotest.run.run(vim.fn.expand("%")) end },
        { '<leader>dt',  function() neotest.run.run({ strategy = "dap" }) end },
      }
    end,
    dependencies = {
      'nvim-neotest/neotest-python'
    }
  },
  { 'nvim-neotest/neotest-python', lazy = true },
  {
    'mfussenegger/nvim-dap',
    keys = function()
      local dap = require("dap")
      return {
        { '<leader>b',  function() dap.toggle_breakpoint() end },
        { '<leader>cb', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
        { '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
        { '<leader>rd', function() dap.continue() end },
        { '<Down>',     function() dap.step_over() end },
        { '<Right>',    function() dap.step_into() end },
        { '<Up>',       function() dap.step_back() end },
        { '<Left>',     function() dap.step_out() end },
        { '<leader>dr', function() dap.repl.open() end },
        { '<leader>rc', function() dap.run_to_cursor() end },
        { '<leader>gt', function() dap.goto_() end },
        { '<leader>lb', function() dap.list_breakpoints() end },
        { '<leader>rl', function() dap.run_last() end },
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
      local dapui = require("dapui")
      return {
        { '<leader>dw', function() dapui.toggle() end },
        { '<leader>v',  function() dapui.eval() end },
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
