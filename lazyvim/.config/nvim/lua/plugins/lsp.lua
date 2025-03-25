return {
  "neovim/nvim-lspconfig",
  opts = {
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
