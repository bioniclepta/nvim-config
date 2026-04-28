return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  highlight = {enable = true},
  indent = {enable = true},
  auto_install = true,
  config = function()
    require('nvim-treesitter').setup {
      -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
      install_dir = vim.fn.stdpath('data') .. '/site'
    }
    require('nvim-treesitter').install({ 'rust', 'python', 'lua' }):wait(300000) -- wait max. 5 minutes
  end
}

