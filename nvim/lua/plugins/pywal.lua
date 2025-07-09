-- ~/.config/nvim/lua/plugins/pywal.lua

return {
  "AlphaTechnolog/pywal.nvim",
  lazy = false,    -- Load at startup
  priority = 1000, -- Ensure it loads first
  config = function()
    vim.cmd.colorscheme("pywal")  -- Apply Pywal colors
  end,
}
