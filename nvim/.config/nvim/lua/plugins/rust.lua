return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            auto_focus = true,
            replace_builtin_hover = true,
          },
        },
      }
    end,
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
  {
    "cordx56/rustowl",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
}
