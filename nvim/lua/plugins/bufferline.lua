return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",       -- Show tabs (not buffers)
        separator_style = "slant",
        show_close_icon = false,
        color_icons = true,   -- Use Pywal colors if available
      },
    })
  end,
}
