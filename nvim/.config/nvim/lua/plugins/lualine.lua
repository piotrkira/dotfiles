return {
  'hoob3rt/lualine.nvim',
  opts = {
    options = {
      theme = 'everforest',
      section_separators = {'', ''},
      component_separators = {'|', '|'},
      disabled_filetypes = {},
      icons_enabled = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { {'mode', upper = true} },
      lualine_b = { {'branch', icon = ''} },
      lualine_c = { {'filename', file_status = true} },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'diff' },
      lualine_z = { 'location'  },
    },
    inactive_sections = {
      lualine_a = { },
      lualine_b = { },
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = { },
      lualine_z = { }
    },
    winbar = {
      lualine_c = { 'filename' },
    },
    inactive_winbar = {
      lualine_c = { 'filename' },
    }
  }
}
