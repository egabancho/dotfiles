return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,

  config = function()
    require('solarized').setup({
        transparent = { enabled = true },
    })
  end,
}
