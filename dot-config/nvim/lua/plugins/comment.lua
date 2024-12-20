return {
    'numToStr/Comment.nvim',
    event = { "BufRead", "BufNewFile" },
    config = function()
      local comment = require("Comment")
      comment.setup({
        toggler = {
            line=";",
        },
        opleader = {
            line=";"
        }
      })
    end,
}
