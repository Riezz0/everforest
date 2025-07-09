-- ~/.config/nvim/lua/plugins/init.lua

return {
  -- Load all plugin files from the plugins/ directory
  require("plugins.pywal"),    -- Pywal colorscheme
  require("plugins.lualine"),   -- Status line
  require("plugins.nvim-tree"), -- File explorer
  require("plugins.telescope"), -- Fuzzy finder (optional)
  require("plugins.bufferline"),  -- Add this line
  -- Add more plugins here...
}
