return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      --theme = 'OceanicNext'
      --theme = 'iceberg_light'
      --theme = 'gruvbox'
      --theme = 'Tomorrow'
      --theme = 'PaperColor'
      theme = 'material',
      icons_enabled = true,
      component_separators = '|',
      section_separators = '',
    }
  }
}
