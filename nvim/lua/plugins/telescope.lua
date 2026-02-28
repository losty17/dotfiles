return {
  'nvim-telescope/telescope.nvim', -- tag = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
  },
  config = function ()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { ".git/", "node_modules/", "*.stories.*", "*.lock" },
        hidden = true,
        no_ignore = true, -- Search in .gitignore
        case_mode = "smart_case",
        theme = "dropdown",
        path_display = { "filename_first" }
      },
      pickers = {
        find_files = {
          theme = "dropdown",
        },
        live_grep = {
          theme = "dropdown",
        },
        defaults = {
          theme = "dropdown",
        },
      }
    })
    require('telescope').load_extension('fzf')
  end,
  keys = {
    {
      "<leader>ff",
      "<cmd>Telescope find_files hidden=true<CR>",
      mode = "n"
    },
    {
      "<M-p>",
      "<cmd>Telescope find_files hidden=true<CR>",
      mode = "n"
    },
    {
      "<leader>fg",
      "<cmd>Telescope live_grep<CR>",
      mode = "n"
    },
    {
      "<M-f>",
      "<cmd>Telescope live_grep<CR>",
      mode = "n"
    },
    {
      "gd",
      "<cmd>Telescope lsp_definitions<CR>",
      mode = "n"
    },
    {
      "gr",
      "<cmd>Telescope lsp_references<CR>",
      mode = "n"
    },
  },
}

