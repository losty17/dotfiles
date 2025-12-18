return {
  'nvim-treesitter/nvim-treesitter',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })()
  end,
  opts = {
    -- ensure_installed = { "typescript", "javascript", "python", "lua", "markdown" },
    ensure_installed = { "python", "lua", "markdown" },
    sync_install = true,
    auto_install = true,
    highlight = {
      enable = true,
    },
  }
}
