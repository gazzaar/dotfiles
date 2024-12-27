return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure the servers table exists
      opts.servers = opts.servers or {}

      -- Modify only the Pyright configuration
      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        filetypes = { "python" },
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern(".git", "pyrightconfig.json")(fname) or vim.fs.dirname(fname)
        end,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
        single_file_support = true,
      })

      -- Add a setup function specifically for Pyright
      opts.setup = opts.setup or {}
      opts.setup.pyright = opts.setup.pyright
        or function(_, server_opts)
          require("lspconfig").pyright.setup(server_opts)
        end
      vim.lsp.set_log_level("debug")
    end,
  },
}
