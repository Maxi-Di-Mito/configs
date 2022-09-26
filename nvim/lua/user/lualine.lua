require('lualine').setup({
  options = {
    theme = 'onedarker'
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1
      }
    },
  }
})
