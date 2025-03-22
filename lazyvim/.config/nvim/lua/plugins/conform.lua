return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft["python"] = { "isort", "black" }
    opts.formatters_by_ft["rust"] = { "rustfmt", lsp_format = "fallback" }
    opts.formatters_by_ft["javascript"] = { "prettierd", "prettier", stop_after_first = true }
    opts.formatters_by_ft["typescript"] = { "prettierd", "prettier", stop_after_first = true }
  end,
}
