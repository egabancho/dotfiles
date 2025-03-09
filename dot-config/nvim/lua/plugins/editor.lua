return {
  "mg979/vim-visual-multi",
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    keys = {
      { "<leader>nn", "<cmd>NoNeckPain<cr>", desc = "[N]o [N]eckpain" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    },
    opts = {},
  },
}
