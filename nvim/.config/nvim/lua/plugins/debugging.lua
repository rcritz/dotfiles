return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "toggle breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "debug continue" })
      vim.keymap.set("n", "<Leader>dx", dap.terminate, { desc = "debug terminate" })
      vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "step over" })
    end,
  },
}
