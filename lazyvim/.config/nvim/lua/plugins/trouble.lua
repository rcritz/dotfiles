-- stylua: ignore
if true then return {} end

return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
      diagnostics = {
        win = { position = "right" },
      },
      symbols = {
        win = { position = "right" },
      },
      todo = {
        win = { position = "right" },
      },
      fzf = {
        win = { position = "right" },
      },
      qflist = {
        win = { position = "right" },
      },
    },
  },
}
