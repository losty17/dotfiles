return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = "seoul256",
      component_separators = '',
      disabled_filetypes = { 'NvimTree' },
    },
    sections = {
      lualine_a = { { 'mode' } },
      lualine_b = { 'filename', 'branch' },
      lualine_c = {
        '%=', --[[ add your center compoentnts here in place of this comment ]]
      },
      lualine_x = {},
      lualine_y = {
        { 'filetype' },
      },
      lualine_z = {
        { 'location' },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
}
