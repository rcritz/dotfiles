return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "jedi_language_server",
        "clangd",
        "bashls",
      },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.jedi_language_server.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      lspconfig.bashls.setup({
        capabilities = capabilities,
      })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "goto Declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "goto definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "goto references" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
    end,
  },
}
