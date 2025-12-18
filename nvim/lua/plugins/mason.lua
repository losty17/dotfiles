return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { 'lua_ls', 'ts_ls', 'pyright', 'gopls' },
        handlers = {
          function(server_name)
            -- Configure general diagnostic display (e.g., signs, virtual text)
            vim.diagnostic.config({
              virtual_text = true, -- Show messages as virtual text
              signs = true,        -- Show icons in the sign column
              update_in_insert = false, -- Don't update diagnostics in insert mode
              float = {          -- Settings for the floating diagnostic window
                source = "always",
                header = "",
                prefix = "",
              },
            })

            -- Configure specific settings for ts_ls or other servers
            if server_name == 'ts_ls' then
              vim.lsp.config("ts_ls", {
                commands = {
                  OrganizeImports = {
                    function ()
                      local params = {
                        command = "_typescript.organizeImports",
                        arguments = {vim.api.nvim_buf_get_name(0)},
                        title = ""
                      }
                      local client = vim.lsp.get_clients({ name = "ts_ls" })[1]
                      client:exec_cmd(params)
                    end,
                    description = "Organize Imports"
                  },
                },
              })
            elseif server_name == 'pyright' then
              vim.lsp.config("pyright", {
                settings = {
                  python = {
                    analysis = {
                      typeCheckingMode = "basic",
                      autoSearchPaths = true,
                      useLibraryCodeForTypes = true,
                    },
                  },
                },
              })
            else
              -- Default config for other language servers
              vim.lsp.config(server_name, {})
            end

            -- Enable the language server
            vim.lsp.enable({ server_name })

            -- Execute organize imports on saves for typescriptreact files
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('LspOrganizeImports', { clear = true }),
              desc = "Organize Imports on Save",
              callback = function (opts)
                if (
                  vim.bo[opts.buf].filetype == 'typescriptreact' or
                  vim.bo[opts.buf].filetype == 'typescript' or
                  vim.bo[opts.buf].filetype == 'javascript' or
                  vim.bo[opts.buf].filetype == 'javascriptreact'
                ) then
                  vim.cmd("OrganizeImports")
                elseif vim.bo[opts.buf].filetype == 'python' then
                  vim.cmd("Black")
                end
              end
            })
          end,
        }
      })

      -- Optional: Keybindings for navigating and displaying diagnostics
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics in loclist' })
    end,
  }
}
