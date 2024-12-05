return {
  'voldikss/vim-floaterm',
  config = function()
    vim.keymap.set('n', '<leader>t', '<Cmd>FloatermToggle<CR>', {})
    vim.keymap.set('t', '<C-x><C-x>', '<Cmd>FloatermToggle<CR>', {})
  end
}
