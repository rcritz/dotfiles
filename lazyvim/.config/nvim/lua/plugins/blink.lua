return {
  "saghen/blink.cmp",
  dependencies = {
    "moyiz/blink-emoji.nvim",
  },
  opts = {
    signature = { enabled = true },
    sources = {
      per_filetype = {
        gitcommit = { "lsp", "path", "snippets", "buffer", "emoji" },
        markdown = { "lsp", "path", "snippets", "buffer", "emoji" },
        sql = { "snippets", "dadbod", "buffer" },
      },
      providers = {
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
        },
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
  },
}
