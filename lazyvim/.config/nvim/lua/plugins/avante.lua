if true then
  return {}
end
return {
  "yetone/avante.nvim",
  opts = {
    provider = "claude-code",

    acp_providers = {
      ["claude-code"] = {
        command = "/opt/homebrew/bin/claude-agent-acp",
        args = {},
        -- env = {
        --   NODE_NO_WARNINGS = "1",
        -- },
      },
    },

    -- fallback path: :AvanteSwitchProvider claude
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        auth_type = "max",
        model = "claude-sonnet-5",
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
    },

    instructions_file = "avante.md",

    behaviour = {
      acp_follow_agent_locations = true,
      confirmation_ui_style = "inline_buttons",
      auto_add_current_file = true,
      minimize_diff = true,

      -- Governs Avante's OWN tools on the direct-API path only.
      -- Reads auto-approved, everything else prompts. Mirrors Manual mode.
      auto_approve_tool_permissions = {
        "read_file",
        "read_file_toplevel_symbols",
        "glob",
        "search_keyword",
        "git_diff",
        "rag_search",
        "web_search",
        "fetch",
      },
    },

    windows = {
      position = "right",
      width = 35,
      wrap = true,
    },
  },
}
