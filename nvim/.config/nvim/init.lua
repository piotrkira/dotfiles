local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config.options")
require("config.keys")
require("config.autocmd")

require("lazy").setup({
  spec = "plugins",
  change_detection = { notify = false },
})

vim.diagnostic.config({
  float = {
    source = 'always',
  }
})
vim.g.copilot_workspace_folders = {"~/dev/consumer/"}
