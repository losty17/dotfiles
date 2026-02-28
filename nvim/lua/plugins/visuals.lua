return {
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, 
    priority = 1000,
    config = function()
      require('github-theme').setup({})

      vim.cmd('colorscheme github_dark_default')
    end,
  },
  { "sphamba/smear-cursor.nvim", opts = {} },
  {
    "karb94/neoscroll.nvim",
    opts = {
      mappings = {
        '<C-u>', '<C-d>',
        '<C-b>', '<C-f>',
        '<C-y>', '<C-e>',
        'zt', 'zz', 'zb',
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 1.0,
      easing = 'quadratic',
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
      ignored_events = { 'WinScrolled', 'CursorMoved' },
    }
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
      vim.opt.termguicolors = true
      require("bufferline").setup({})
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        '*';
        css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
        html = { names = false; }; -- Disable parsing "names" like Blue or Gray in html files.
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  }
}
