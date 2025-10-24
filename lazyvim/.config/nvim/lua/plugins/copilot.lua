return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      accept = false,
    },
    filetypes = {
      markdown = true,
      help = false,
      gitcommit = true,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["*"] = true,
    },
  },
}
