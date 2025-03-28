return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.7',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
--     config = function()
--       local builtin = require('telescope.builtin')
--       vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find files" })
--       vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "live grep" })
--       vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "find buffers" })
--     end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      -- This is your opts table
      require("telescope").setup {
        pickers = {
          find_files = {
            hidden = true
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }

          }
        }
      }

      require("telescope").load_extension("ui-select")
    end
  },
}
