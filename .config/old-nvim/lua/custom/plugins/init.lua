-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  {
    'nvim-orgmode/orgmode',
    enabled = true,
    event = 'VeryLazy',
    ft = { 'org' }, -- only load for Org files
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('orgmode').setup {
        org_agenda_files = '~/.nb/klog/**/*',
        org_default_notes_file = '~/.nb/klog/area/log.org',
        mappings = {
          org = {
            org_todo = 'cot',
            org_todo_prev = 'coT',
            org_toggle_checkbox = '<C-c>',
          },
        },
        org_todo_keywords = { 'TODO(t)', '|', 'DONE', 'CANCELED', 'FAILED', 'SIMIDONE', 'ALLMOSTDONE' },
        org_todo_keyword_faces = {},
        org_startup_folded = 'overview',
        org_folding_level = 0,
        org_hide_emphasis_markers = true,
        org_startup_indented = false,
        org_adapt_indentation = true,

        org_capture_templates = {
          i = {
            description = 'Ideas',
            template = '* %?',
            target = '~/.nb/klog/area/ideas.org',
            -- properties = {
            -- 	empty_lines = {
            -- 		before = 1,
            -- 		after = 1,
            -- 	},
            -- },
          },
          l = {
            description = 'Quick Links',
            template = '* [[%x][%?]]',
            target = '~/.nb/klog/resources/links.org',
            -- properties = {
            -- 	empty_lines = {
            -- 		before = 1,
            -- 		after = 1,
            -- 	},
            -- },
          },
        },
      }
    end,
  },

  {
    'chipsenkbeil/org-roam.nvim',
    enabled = true,
    tag = '0.2.0',
    -- ft = { 'org' }, -- only load for Org files
    lazy = false,
    dependencies = {
      'nvim-orgmode/orgmode',
      tag = '0.7.0',
    },
    config = function()
      require('org-roam').setup {
        directory = '~/.nb/klog/resources/room/',
        -- optional
        org_files = {
          '~/.nb/klog/**/*.org',
        },
      }
    end,
  },
}
