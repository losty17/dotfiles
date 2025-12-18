return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup {
      '*'; -- Highlight all files, but customize some others.
      css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
      html = { names = false; }; -- Disable parsing "names" like Blue or Gray in html files.
    }
  end,
}
