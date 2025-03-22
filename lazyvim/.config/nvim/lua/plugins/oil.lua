return {
  "stevearc/oil.nvim",
  opts = {
    view_options = {
      show_hidden = false,
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "-", "<Cmd>Oil --float<CR>", desc = "Open parent directory" },
  },
}
