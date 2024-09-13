return {
  {
    "github/copilot.vim",
    config = function ()
      vim.g.copilot_workspace_folders = {"~/dev/consumer/"}
      vim.g.copilot_enabled = false
    end,
    cmd = "Copilot"
  }
}
