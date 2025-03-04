return {
  {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
        enabled = true, -- Master switch to enable transparency
        pmenu = true, -- Popup menu (e.g., autocomplete suggestions)
        normal = true, -- Main editor window background
        normalfloat = true, -- Floating windows
        neotree = true, -- Neo-tree file explorer
        nvimtree = true, -- Nvim-tree file explorer
        whichkey = true, -- Which-key popup
        telescope = true, -- Telescope fuzzy finder
        lazy = true, -- Lazy plugin manager UI
        mason = true, -- Mason manage external tooling
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = { flavour = "frappe", transparent_background = true },
    config = function(_, opts)
      vim.o.termguicolors = true
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
