-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },  -- Optional: for icons
  keys = {  -- Keybindings to toggle the file explorer
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 35,  -- Width of the tree (columns)
      },
      renderer = {
        group_empty = true,  -- Collapse empty folders
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,  -- Show hidden files (e.g., .gitignore)
      },
      git = {
        ignore = false,  -- Show git status icons
      },
    })
  end,
}
