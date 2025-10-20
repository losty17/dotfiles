return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { 'lua_ls', 'ts_ls', 'pyright' },
        handlers = {
          function(server_name)
            -- local lspconfig = require('lspconfig')

            if server_name ~= 'ts_ls' then
              vim.lsp.config(server_name, {})
              vim.lsp.enable({ server_name })
              return
            end

            -- typescript settings
            vim.lsp.config("ts_ls", {
              commands = {
                OrganizeImports = {
                  function ()
                    local params = {
                      command = "_typescript.organizeImports",
                      arguments = {vim.api.nvim_buf_get_name(0)},
                      title = ""
                    }

                    -- vim.lsp.buf.execute_command(params)

                    local client = vim.lsp.get_clients({ name = "ts_ls" })[1]
                    client:exec_cmd(params)
                  end,
                  description = "Organize Imports"
                },
              }
            })

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

            vim.lsp.enable({ "ts_ls", "pyright" })

            -- Execute orginize imports on saves
            vim.api.nvim_create_autocmd('BufWritePre', {
              desc = "Organize Imports on Save",
              callback = function (opts)
                if vim.bo[opts.buf].filetype == 'typescriptreact' then
                  vim.cmd("OrganizeImports")
                end
              end
            })
          end,
        }
      })
    end,
  }
}
