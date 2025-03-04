return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    require("oil").setup()
    vim.keymap.set("n", "-", "<Cmd>Oil --float<CR>", { desc = "Open parent directory" })
  end
}
