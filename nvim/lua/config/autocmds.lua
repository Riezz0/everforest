-- ~/.config/nvim/lua/config/autocmds.lua

-- Auto-reload Pywal colors when changed
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",  -- Pywal sends this signal on updates
  callback = function()
    vim.schedule(function()
      vim.cmd.colorscheme("pywal")  -- Reapply colorscheme
    end)
  end,
})
