return {
  {
    "m4xshen/autoclose.nvim",
    config = function ()
      require("autoclose").setup({
        options = {
          disable_when_touch = true,
          pair_spaces = true,
          auto_indent = true,
        }
      })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function ()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        }
      })
    end
  }
}
