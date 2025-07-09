-- ~/.config/nvim/init.lua

-- Set leader key early (optional)
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
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

-- Load Neovim settings
require("config.options")   -- Basic settings (line numbers, tabs, etc.)
require("config.keymaps")  -- Keybindings
require("config.autocmds") -- Autocommands (e.g., Pywal refresh)

-- Load plugins
require("lazy").setup("plugins")  -- Loads all plugins from ~/lua/plugins/
