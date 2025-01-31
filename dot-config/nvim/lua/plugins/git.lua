return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = true,
  opts = {
    kind = "floating",
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Neogit (repository of the current file)" },
  },
}
