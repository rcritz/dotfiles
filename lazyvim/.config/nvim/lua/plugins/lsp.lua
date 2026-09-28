return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    diagnostics = {
      virtual_text = {
        prefix = "icons",
      },
    },
    -- servers = {
    --   harper_ls = {
    --     enabled = true,
    --     filetypes = { "markdown" },
    --     settings = {
    --       ["harper_ls"] = {
    --         userDictPath = "~/.config/nvim/spell/en.utf-8.add",
    --         -- linters = {
    --         -- },
    --         markdown = {
    --           IgnoreLinkTitle = true,
    --         },
    --       },
    --     },
    --   },
    -- },
  },
}
