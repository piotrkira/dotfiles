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
        { '<leader>rt', function() neotest.run.run() end },
        { '<leader>rat', function() neotest.run.run(vim.fn.expand("%")) end },
        { '<leader>dt', function() neotest.run.run({strategy = "dap"}) end },
      }
    end,
    dependencies = {
     'nvim-neotest/neotest-python'
    }
  },
  { 'nvim-neotest/neotest-python', lazy=true },
  {
    'mfussenegger/nvim-dap',
    keys = function()
      local dap = require("dap")
      return {
        { '<leader>b', function() dap.toggle_breakpoint() end },
        { '<leader>cb', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
        { '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
        { '<leader>dc', function() dap.continue() end },
        { '<Down>', function() dap.step_over() end },
        { '<Right>', function() dap.step_into() end },
        { '<Up>', function() dap.step_back() end },
        { '<Left>', function() dap.step_out() end },
        { '<leader>dr', function() dap.repl.open() end },
        { '<leader>rc', function() dap.run_to_cursor() end },
        { '<leader>gt', function() dap.goto_() end },
        { '<leader>lb', function() dap.list_breakpoints() end },
        { '<leader>rl', function() dap.run_last() end },
      }
    end,
    init = function()
      vim.fn.sign_define('DapBreakpoint', {text='', texthl='Debug', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='Debug', linehl='', numhl=''})
      vim.fn.sign_define('DapLogPoint', {text='', texthl='Debug', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='', texthl='Debug', linehl='', numhl=''})
    end,
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'theHamsta/nvim-dap-virtual-text',
    }
  },
  {
    'rcarriga/nvim-dap-ui',
    keys = function()
      local dapui = require("dapui")
      return {
        { '<leader>dw', function() dapui.toggle() end },
        { '<leader>v', function() dapui.eval() end },
      }
    end,
    config = function()
      require("dapui").setup()
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
