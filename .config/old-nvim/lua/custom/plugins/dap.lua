return {
  -- NIO library required by nvim-dap-ui
  {
    'nvim-neotest/nvim-nio',
    lazy = true,
  },

  -- DAP for debugging
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      local home = os.getenv 'HOME'
      local mason_path = vim.fn.stdpath 'data' .. '/mason'

      -- Java Debug Adapter (for JDTLS)
      dap.configurations.java = {
        {
          type = 'java',
          request = 'attach',
          name = 'Debug (Attach) - Remote',
          hostName = '127.0.0.1',
          port = 5005,
        },
        {
          type = 'java',
          request = 'launch',
          name = 'Debug (Launch) - Current File',
          mainClass = '${file}',
        },
      }

      -- C/C++ Debug Adapters
      -- Using cppdbg (Microsoft C++ debugger)
      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = mason_path .. '/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
      }

      -- Using codelldb (LLVM debugger - generally better for macOS)
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = mason_path .. '/bin/codelldb',
          args = { '--port', '${port}' },
        },
        name = 'lldb',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch file (codelldb)',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = false,
          args = {},
          runInTerminal = false,
        },
        {
          name = 'Launch file (cppdbg)',
          type = 'cppdbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'cppdbg',
          request = 'launch',
          MIMode = 'gdb',
          miDebuggerServerAddress = 'localhost:1234',
          miDebuggerPath = '/usr/bin/gdb',
          cwd = '${workspaceFolder}',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }

      -- C and Rust use the same configurations as C++
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- Python Debug Adapter
      -- dap.adapters.python = {
      --   type = 'executable',
      --   command = mason_path .. '/packages/debugpy/venv/bin/python',
      --   args = { '-m', 'debugpy.adapter' },
      -- }

      --   dap.configurations.python = {
      --     {
      --       type = 'python',
      --       request = 'launch',
      --       name = 'Launch file',
      --       program = '${file}',
      --       pythonPath = function()
      -- -- Try to use virtual environment python if available
      -- local cwd = vim.fn.getcwd()
      -- if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
      --   return cwd .. '/venv/bin/python'
      -- elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
      --   return cwd .. '/.venv/bin/python'
      -- else
      --   return '/usr/bin/python3'
      -- end
      --       end,
      --     },
      --   }

      -- Keymaps
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F9>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<Leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Conditional Breakpoint' })
    end,
  },

  -- DAP UI for a better debugging experience
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dapui = require 'dapui'

      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              'breakpoints',
              'stacks',
              'watches',
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              'repl',
              'console',
            },
            size = 0.25,
            position = 'bottom',
          },
        },
      }

      -- Breakpoint symbols
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '🟡', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '⭕', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = 'debugPC', numhl = '' })

      -- Auto-open/close DAP UI when debugging starts/stops
      local dap = require 'dap'
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Keymaps for DAP UI
      vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
      vim.keymap.set('n', '<Leader>de', function()
        dapui.eval(nil, { enter = true })
      end, { desc = 'Debug: Evaluate Expression' })
    end,
  },

  -- Mason integration for DAPs
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
    config = function()
      require('mason-nvim-dap').setup {
        ensure_installed = { 'codelldb', 'cppdbg' },
        automatic_installation = true,
        handlers = {}, -- Use default handlers
      }
    end,
  },
}
