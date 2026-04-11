return {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  enabled = false,
  ft = { 'java' },
  config = function()
    local jdtls_group = vim.api.nvim_create_augroup('jdtls_lsp', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      group = jdtls_group,
      pattern = 'java',
      callback = function()
        -- Prevent duplicate attachment
        local clients = vim.lsp.get_clients { bufnr = 0, name = 'jdtls' }
        if #clients > 0 then
          return
        end

        local jdtls = require 'jdtls'
        local home = os.getenv 'HOME'

        -- Homebrew paths
        local jdtls_install = '/opt/homebrew/opt/jdtls/libexec'
        local lombok_jar = jdtls_install .. '/lombok.jar'

        -- Project setup
        local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
        local root_dir = require('jdtls.setup').find_root(root_markers)

        if not root_dir then
          root_dir = vim.fn.expand '%:p:h'
          vim.notify('No Java project root found – using single-file mode', vim.log.levels.WARN)
        end

        local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
        local workspace_dir = home .. '/.local/share/nvim/jdtls-workspace/' .. project_name

        -- Determine config directory (Mac ARM vs Intel)
        local config_dir = jdtls_install .. '/config_mac'
        if vim.fn.isdirectory(jdtls_install .. '/config_mac_arm') == 1 then
          config_dir = jdtls_install .. '/config_mac_arm'
        end

        -- Build command
        local cmd = {
          'jdtls',
          '-configuration',
          config_dir,
          '-data',
          workspace_dir,
        }

        -- Add Lombok agent (CRITICAL for @Data, @Getter, @Setter, etc.)
        if vim.fn.filereadable(lombok_jar) == 1 then
          table.insert(cmd, '--jvm-arg=-javaagent:' .. lombok_jar)
        end

        -- Load Java test and debug bundles from Mason
        local bundles = {}
        local mason_path = vim.fn.stdpath 'data' .. '/mason/packages'

        -- Java Debug Adapter
        local java_debug_path = mason_path .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'
        vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug_path), '\n'))

        -- Java Test
        local java_test_path = mason_path .. '/java-test/extension/server/*.jar'
        vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path), '\n'))

        local config = {
          cmd = cmd,
          root_dir = root_dir,
          settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { preferred = 'fernflower' },
              completion = {
                favoriteStaticMembers = {
                  'org.junit.jupiter.api.Assertions.*',
                  'org.junit.Assert.*',
                  'org.mockito.Mockito.*',
                  'java.util.Objects.requireNonNull',
                  'java.util.Objects.requireNonNullElse',
                },
                filteredTypes = {
                  'com.sun.*',
                  'io.micrometer.shaded.*',
                  'java.awt.*',
                  'jdk.*',
                  'sun.*',
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
              codeGeneration = {
                toString = {
                  template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                },
                useBlocks = true,
              },
              configuration = {
                runtimes = {
                  -- Add your Java runtimes here if needed
                  {
                    name = 'JavaSE-21',
                    path = '/opt/homebrew/Cellar/openjdk@21/21.0.9/libexec/openjdk.jdk/Contents/Home',
                  },
                },
              },
              inlayHints = {
                parameterNames = { enabled = 'all' },
              },
            },
          },
          init_options = {
            bundles = bundles,
            extendedClientCapabilities = {
              classFileContentsSupport = true,
            },
          },
          capabilities = require('blink.cmp').get_lsp_capabilities(),
          on_attach = function(client, bufnr)
            -- Keymaps
            local opts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set('n', '<leader>co', function()
              require('jdtls').organize_imports()
            end, vim.tbl_extend('force', opts, { desc = 'Organize Imports' }))

            vim.keymap.set('n', '<leader>cv', function()
              require('jdtls').extract_variable()
            end, vim.tbl_extend('force', opts, { desc = 'Extract Variable' }))

            vim.keymap.set('v', '<leader>cv', function()
              require('jdtls').extract_variable(true)
            end, vim.tbl_extend('force', opts, { desc = 'Extract Variable' }))

            vim.keymap.set('n', '<leader>cc', function()
              require('jdtls').extract_constant()
            end, vim.tbl_extend('force', opts, { desc = 'Extract Constant' }))

            vim.keymap.set('v', '<leader>cc', function()
              require('jdtls').extract_constant(true)
            end, vim.tbl_extend('force', opts, { desc = 'Extract Constant' }))

            vim.keymap.set('v', '<leader>cm', function()
              require('jdtls').extract_method(true)
            end, vim.tbl_extend('force', opts, { desc = 'Extract Method' }))

            vim.keymap.set('n', '<leader>ct', function()
              require('jdtls').test_class()
            end, vim.tbl_extend('force', opts, { desc = 'Test Class' }))

            vim.keymap.set('n', '<leader>cn', function()
              require('jdtls').test_nearest_method()
            end, vim.tbl_extend('force', opts, { desc = 'Test Nearest Method' }))

            -- Enable inlay hints if supported
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          end,
        }

        -- Start jdtls
        jdtls.start_or_attach(config)
      end,
    })
  end,
}
