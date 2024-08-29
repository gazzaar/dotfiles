return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require("telescope.actions")

    -- Extend existing keymaps
    opts.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
    opts.defaults.mappings.i["<C-j>"] = actions.move_selection_next

    return opts
  end,
}
